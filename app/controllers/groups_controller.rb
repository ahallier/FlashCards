class GroupsController < ApplicationController
    before_filter :set_current_user
    def update_params
        params.permit(:id)
    end
    
    def create_params
        params.require(:group).permit(:title, :public)
    end
    
    def remove_deck_from_group
        puts 'Got call to remove deck from group.'
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to remove decks from a group."
            redirect_to decks_path and return
        end
        
        group_id = params[:group_id].to_i
        
        if !user.is_in_group(group_id)
            flash[:notice] = "You must be in a group to delete decks from it."
            redirect_to decks_path and return
        end
        
        deck_id = params[:deck_id].to_i
        group = Group.find_by_id(group_id)
        group.decks = group.decks.select { |d| d.id != deck_id }
        group.decks
        
        redirect_to group_display_path(group_id)
    end

    def show_add_deck_to_group
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to add decks to a group."
            redirect_to decks_path and return
        end
        
        group_id = params[:id]
        group = Group.find_by_id(group_id)
        
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        
        unless @current_user.id == group.users.find_by_id(@current_user.id) || group.public == true
            # Unless user is a memeber of the group, or the group is public
            flash[:notice] = "Group is private or you are not a member"
            redirect_to groups_path and return
        end
        
        decks_to_display = Deck.where(:public => true, :user_id =>[nil, user.id])
        user_decks_to_display = Deck.where(:user_id => @current_user)
        group = Group.find_by_id group_id
        decks1 = decks_to_display.select { |d| group.decks.all? { |gd| gd.id != d.id } }
        decks2 = user_decks_to_display.select { |d| group.decks.all? { |gd| gd.id != d.id } }
        alldecks = decks1+decks2
        @decks = alldecks.uniq{|x| x.id}
        if @decks == nil or @decks.length == 0
            flash[:notice] = "No decks to add."
            redirect_to group_display_path(group_id) and return
        end
        @group_id = group_id
        render 'add-deck' and return
    end
    
    def add_deck_to_group
        puts "Got request to add deck to group"
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to view this page."
            redirect_to decks_path and return
        end
        group_id = params[:id]
        
        group = Group.find_by_id(group_id)
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        
        unless @current_user.id == group.users.find_by_id(@current_user.id) || group.public == true
            # Unless user is a memeber of the group, or the group is public
            flash[:notice] = "Group is private or you are not a member"
            redirect_to groups_path and return
        end
        

        deck_ids = params[:decks].keys
        
        puts "Got group id: #{group_id}"
        

        
        deck_ids.each do |d_id|
            # Add any decks to the group that were not already in the group
            unless group.decks.any? { |d| d.id == d_id.to_i }
                group.decks << Deck.find_by_id(d_id)
            end
        end
        group.save
        
        # Maybe we should redirect to groups_path here.
        redirect_to group_display_path(group_id)
    end
    
    def show_add_user_to_group
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to add users to a group."
            redirect_to decks_path and return
        end
        
        group_id = params[:id]
        group = Group.find_by_id(group_id)
        
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        puts 'Current user: '
        puts @current_user.id
        puts group.owner_id
        if !group.public || group.owner_id != @current_user.id
            # add users if group is private and user is owner
            flash[:notice] = "You must be a owner to add members to a private group."
            redirect_to groups_path and return
        end
        
        users_to_display = User.all
        group = Group.find_by_id group_id
        @users = users_to_display.select { |u| group.users.all? { |gu| gu.id != u.id } }
        if @users == nil or @users.length == 0
            flash[:notice] = "No users to add."
            redirect_to group_display_path(group_id) and return
        end
        @group_id = group_id
        render 'add-user' and return
    end
    
    def add_user_to_group
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to view this page."
            redirect_to decks_path and return
        end
        puts "Got request to add user to group"
        group_id = params[:id]
        
        group = Group.find_by_id(group_id)
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        
        unless (!group.public && group.owner_id == @current_user.id)
            #add users if group is private and user is owner
            flash[:notice] = "You must be a owner to add members to a private group."
            redirect_to groups_path and return
        end

        user_ids = params[:users].keys
        
        puts "Got group id: #{group_id}"
        
        user_ids.each do |u_id|
            # Add any decks to the group that were not already in the group
            unless group.users.any? { |u| u.id == u_id.to_i }
                group.users << User.find_by_id(u_id)
            end
        end
        group.save
        
        # Maybe we should redirect to groups_path here.
        redirect_to group_display_path(group_id)
    end

    def index
        @groups = Group.where(public: true)
    end
    
    def display
        id = update_params[:id]
        @group = Group.find(id)
        @group_decks = @group.decks
    end
    
    def new
        #default render new template
    end
    
    def create
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to create a group."
            redirect_to decks_path and return
        end
        group_params = create_params
        # TODO: Make constants somewhere (config/constanst file?) that represent default deck values.
        group_params[:created_at] = DateTime.now
        group_params[:updated_at] = DateTime.now
        if group_params[:public] == 'Yes'
            group_params[:public]=true
        else
            group_params[:public]=false
        end
        group_params[:owner_id]=@current_user.id
        newg = Group.create!(group_params)
        newg.users << @current_user
        flash[:notice] = "Successfully created group."
        redirect_to groups_path
    end

    def addUser
        @group = Group.find params[:id]
        user = User.find_by_session_token(session[:session_token])
        if user == nil
            flash[:notice] = "You must be logged in to join a group."
            redirect_to decks_path and return
        end
        @group.users << user
        flash[:notice] = "#{user.email} joined #{@group.title}."
        redirect_to groups_path and return
    end
end
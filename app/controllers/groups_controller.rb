class GroupsController < ApplicationController
    
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
        
        unless group.public
            # this will need to take into account users that have access
            # to private groups later.
            flash[:notice] = "Group is private!"
            redirect_to decks_path and return
        end
        decks_to_display = Deck.where(:public => true, :user_id =>[nil, user.id])
        group = Group.find_by_id group_id
        @decks = decks_to_display.select { |d| group.decks.all? { |gd| gd.id != d.id } }
        if @decks == nil or @decks.length == 0
            flash[:notice] = "No decks to add."
            redirect_to group_display_path(group_id) and return
        end
        @group_id = group_id
        render 'add-deck' and return
    end
    
    def add_deck_to_group
        puts "Got request to add deck to group"
        group_id = params[:id]
        
        group = Group.find_by_id(group_id)
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        unless group.public
            # this will need to take into account users that have access
            # to private groups later.
            flash[:notice] = "Group is private!"
            redirect_to decks_path and return
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
            flash[:notice] = "You must be logged in to add decks to a group."
            redirect_to decks_path and return
        end
        
        group_id = params[:id]
        group = Group.find_by_id(group_id)
        
        if group == nil
            flash[:notice] = "Group does not exist."
            redirect_to decks_path and return
        end
        
        unless group.public
            # this will need to take into account users that have access
            # to private groups later.
            flash[:notice] = "Group is private!"
            redirect_to decks_path and return
        end
        
        users_to_display = User.fin
        group = Group.find_by_id group_id
        @users = users_to_display.select { |d| group.users.all? { |gu| gu.id != u.id } }
        if @users == nil or @users.length == 0
            flash[:notice] = "No decks to add."
            redirect_to group_display_path(group_id) and return
        end
        @group_id = group_id
        render 'add-deck' and return
    end
    
    def is_public?
        
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
        group_params = create_params
        # TODO: Make constants somewhere (config/constanst file?) that represent default deck values.
        group_params[:created_at] = DateTime.now
        group_params[:updated_at] = DateTime.now
        if group_params[:public] == 'Yes'
            group_params[:public]=true
        else
            group_params[:public]=false
        end
        Group.create!(group_params)
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
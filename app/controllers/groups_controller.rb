class GroupsController < ApplicationController
    
    def index_params
        params.permit(:sort, :random)
    end
    
    def create_params
        params.require(:group).permit(:title)
    end
    
    def update_params
        params.permit(:title, :updated_at, :id)
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

    def index
        sort = index_params[:sort] || session[:sort]
        
        if sort == nil
            @groups = Group.all
            render 'index' and return
        end
        
        if index_params[:sort] != session[:sort]
            # switch ascending and descending if the user clicks on the header multiple times
            session[:ascending] = true
            session[:sort] = sort
            #redirect_to :sort => sort and return
        elsif index_params[:random] == session[:random]
            # if the random token is new and the sort parameter is the same as the sort session token
            # that means that the user clicked on the same header they did last time so we reverse the
            # ordering. If the random token is different, that means the user just refreshed the page and
            # we don't want to reverse the ordering.
            session[:ascending] = !session[:ascending]
        end
        
        asc_or_desc = session[:ascending] ? 'asc' : 'desc'
        
        # the call to lower() make the search case insensitive
        ordering = 'lower('+sort+') '+ asc_or_desc

        @groups = Group.where(public: true).order(ordering)
        # the random token is used to ensure that the ordering doesn't get reversed on page refresh.
        @random = SecureRandom.uuid
        session[:random] = @random
    end
    
    def display
        id = update_params[:id]
        #deck_ids = GroupsDecks.where(group_id: id).take
        #@decks = Deck.where(id: deck_ids.deck_id).take 
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
        Group.create!(group_params)
        flash[:notice] = "Successfully created group."
        redirect_to groups_path
    end
    
    def destroy
        @group = Group.find(params[:id])
        @group.destroy
        flash[:notice] = "Group '#{@group.title}' was deleted."
        redirect_to groups_path
    end
    
    def edit
        @group = Group.find params[:id]
    end
    
    def update
        group = Group.find update_params[:id]
        group.title = update_params[:title]
        group.updated_at = DateTime.now
        group.public = update_params[:public] == 'Yes'
        group.save
        
        redirect_to groups_path
    end
    def addUser
        @group = Group.find params[:id]
        @user = @group.users.create(:user_id = User.find_by_session)
        redirect_to groups_path
    end
end
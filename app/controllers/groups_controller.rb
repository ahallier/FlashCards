class GroupsController < ApplicationController
    
    
    def index_params
        params.permit(:sort, :random)
    end
    
    def create_params
        params.require(:group).permit(:title, :public)
    end
    
    def update_params
        params.require(:group).permit(:title, :updated_at, :public)
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
    
    def new
        #default render new template
    end
    
    def create
        group_params = create_params
        # TODO: Make constants somewhere (config/constanst file?) that represent default deck values.
        group_params[:created_at] = DateTime.now
        group_params[:updated_at] = DateTime.now
        group_params[:public] = group_params[:public]
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
        #@deck = Deck.find params[:id]
        #@card = @deck.cards.create(:front => params["card"]["front"], :back =>params["card"]["back"] )
        redirect_to groups_path
    end
end
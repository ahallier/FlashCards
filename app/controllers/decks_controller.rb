class DecksController < ApplicationController
    before_filter :set_current_user
    require 'will_paginate/array' 
    
    def index_params
        params.permit(:sort, :random)
    end
    
    def create_params
        params.require(:deck).permit(:title, :category, :public)
    end
    
    def update_params
        params.require(:deck).permit(:id, :title, :category, :public)
    end
    

    def index
        sort = index_params[:sort] || session[:sort]
        
        if sort == nil
            @decks = Deck.all.where(public: true)
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

        @decks = Deck.search(params[:search]).where(public: true).order(ordering)
        #@decks = @decks.paginate(:page => params[:page], :per_page => 5)
        
        # the random token is used to ensure that the ordering doesn't get reversed on page refresh.
        @random = SecureRandom.uuid
        session[:random] = @random
    end
    
    def new
        #default render new template
    end
    
    def create
        deck_params = create_params
        # TODO: Make constants somewhere (config/constanst file?) that represent default deck values.
        deck_params[:score] = 0
        deck_params[:created_at] = DateTime.now
        deck_params[:updated_at] = DateTime.now
        deck_params[:public] = deck_params[:public] == 'Yes'
        Deck.create!(deck_params)
        flash[:notice] = "Successfully created deck."
        redirect_to decks_path
    end
    
    def destroy
        @deck = Deck.find(params[:id])
        @deck.destroy
        flash[:notice] = "Deck '#{@deck.title}' was deleted."
        redirect_to decks_path
    end
    
    def edit
        @deck = Deck.find params[:id]
    end
    
    def update
        deck = Deck.find update_params[:id]
        deck.title = update_params[:title]
        deck.category = update_params[:category]
        deck.updated_at = DateTime.now
        deck.public = update_params[:public] == 'Yes'
        deck.save
        
        redirect_to decks_path
    end
    def addCard
        @deck = Deck.find params[:id]
        @card = @deck.cards.create(:front => params["card"]["front"], :back =>params["card"]["back"] )
        redirect_to card_display_path
    end
    def writecard
        #default render writecard template
    end
end
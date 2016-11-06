class DecksController < ApplicationController
    
    
    def create_params
        params.require(:deck).permit(:title, :category, :public)
    end
    
    def update_params
        params.require(:deck).permit(:id, :title, :category, :public)
    end

    def index
        @decks = Deck.all
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
        puts "deck"+@deck.id.to_s
        #puts "params"+card_params.to_s
        @card = @deck.cards.create(:front => params["card"]["front"], :back =>params["card"]["back"] )
        redirect_to decks_path
    end
    def writecard
        #default render writecard template
    end
end
class CardsController < ApplicationController
    
    def create_params
        params.require(:card).permit(:deck_id, :front, :back)
    end
    
    def update_params
        params.require(:card).permit(:id, :deck_id, :front, :back)
    end

    def index
        @deck = Deck.find params[:id]
        puts "deck"+@deck.id.to_s
        @cards = Card.where(deck_id: @deck)
    end
    
    def new
        #default render new template
    end
    
    def create
        card_params = create_params
        #card_params[:deck_id] = 1
        @card = Card.create!(card_params)
        flash[:notice] = "Successfully added card."
        redirect_to cards_path
    end
    
    def edit
         @card = Card.find params[:id]
    end
    
    def update
        card = Card.find update_params[:id]
        card.front = update_params[:front]
        card.back = update_params[:back]
        card.save
 
        @card = Card.find params[:id]
        redirect_to card_display_path(@card.deck_id)
    end
    
    def destroy
        @card = Card.find(params[:id])
        @card.destroy
        flash[:notice] = "Card was deleted."
        redirect_to card_display_path(@card.deck_i)
    end
    
end
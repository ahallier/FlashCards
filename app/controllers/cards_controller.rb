class CardsController < ApplicationController
    
    def create_params
        params.require(:card).permit(:deck_id, :front, :back)
    end

    def index
        @cards = Card.all
        
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
    
end
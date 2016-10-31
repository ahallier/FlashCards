class DecksController < ApplicationController
    
    def create_params
        params.require(:deck).permit(:title, :category, :public)
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
        Deck.create!(deck_params)
        flash[:notice] = "Successfully created deck."
        redirect_to decks_path
    end
end
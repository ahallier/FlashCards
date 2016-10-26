class DecksController < ApplicationController

    def index
        @decks = Deck.all
    end
    
    def new
        #default render new template
    end
end
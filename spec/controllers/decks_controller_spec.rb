require 'spec_helper'
require 'rails_helper'

describe DecksController do
    describe 'Adding new deck' do
        it 'should call the Deck.create! method' do
            expect(Deck).to receive(:create!)
            post :create, {:deck =>{:title => 'Test',  :category => 'TestCat', :public => true}}
        end
    end
end

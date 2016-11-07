require 'spec_helper'
require 'rails_helper'

describe DecksController do
    before :each do
      @deck = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true})
    end
    describe 'Visiting index' do 
        it 'should call Deck.all' do
            expect(Deck).to receive(:all)
            get :index
        end
    end
    describe 'Adding new deck' do
        it 'should call the Deck.create! method' do
            expect(Deck).to receive(:create!)
            post :create, {:deck =>{:title => 'Test',  :category => 'TestCat', :public => true}}
        end
    end
    describe 'updating deck' do
        it 'should call the Deck.save method' do
            deck_spy = spy(Deck)
            allow(Deck).to receive(:find).and_return deck_spy
            expect(deck_spy).to receive(:save)
            put :update, {:id=>1, :deck =>{:title => 'Test',  :category => 'TestCat', :public => true}}
        end
    end
    describe 'deleting deck' do
        it 'should call the Deck.destroy method' do
            deck_spy = spy(Deck)
            allow(Deck).to receive(:find).and_return deck_spy
            expect(deck_spy).to receive(:destroy)
            delete :destroy, {:id=>1}
        end
    end
    describe 'Editing deck' do 
        it 'should call Deck.edit' do
            expect(Deck).to receive(:find)
            get :edit, {:id => 1}
        end
    end
    describe 'Adding Card to Deck' do
        it 'should call the Deck.addCard method' do
            deck_spy = spy(Deck)
            allow(Deck).to receive(:find).and_return deck_spy
            expect(deck_spy.CardsController).to receive(:create)
            get :addCard, {"card"=>{"front"=>"frontofcard", "back"=>"backofcard"}, "id"=>"1"}
            expect(response).to redirect_to('/cards/1/display')
        end
    end
end

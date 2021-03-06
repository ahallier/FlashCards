require 'spec_helper'
require 'rails_helper'

describe DecksController, :type => :controller do
    before :each do
      @deck = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true})
      @deck2 = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true})

############################### | ########################################################## | #########################################
############################### V Do not change these! Use them as they are or add your own. V #########################################
        
        @user = User.create!({
            :email => 'albert@gmail.com', 
            :password => "albert", 
            :session_token => 'abcde',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        

###############################^ Do not change these! Use them as they are or add your own. ^ #####################################
############################## | ########################################################## | #####################################
    end
    describe 'Visiting index' do 
        it 'should call Deck.all' do
            expect(Deck).to receive(:all).and_return(spy(Deck))
            get :index
        end
    end
    describe 'Adding new deck' do
        it 'should redirect to decks page if not logged in' do
            @request.session[:session_token] = 0
            post :create, {:deck =>{:title => 'Test',  :category => 'TestCat', :public => true}}
            expect(@request).to redirect_to(decks_path)
        end
        it 'should call the Deck.create! method' do
            @request.session[:session_token] = @user.session_token
            deck_spy = spy(Deck)
            expect(Deck).to receive(:create!).and_return(deck_spy)
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
    describe 'Sorting By Field Once' do
        it 'should sort ascending' do
            get :index, {:sort => :score}
            
            expect(@request.session[:ascending]).to be true
        end
    end
    describe 'Sorting By Same Field Twice' do
        it 'should sort descending' do
            get :index, {:sort => :score, :random => :abc}
            get :index, {:sort => :score, :random => @request.session[:random]}

            expect(@request.session[:ascending]).to be false

        end
    end
    describe 'Favoriting a Deck' do
        it 'should select the deck of the page it is on' do
            deck_spy = spy(Deck)
            expect(Deck).to receive(:find).with("1").and_return(deck_spy)
            get :addAsFavorite, {"id" => "1"}
        end
        it 'should call the favorite create method' do
            @request.session[:session_token] = @user.session_token
            expect(Favorite).to receive(:create).with({:user_id=>@user.id,:deck_id=>1})
            get :addAsFavorite, {"id" => "1"}
        end
        it 'should redirect to decks_path' do
            get :addAsFavorite, {"id" => "1"}
            expect(response).to redirect_to('/decks')
        end
        it 'should redirect if you have favorited it already' do
            @request.session[:session_token] = @user.session_token
            @favorite = Favorite.create({
                :user_id => @user.id,
                :deck_id => 1
            })
            @favorite.save
            
            get :addAsFavorite, {"id" => "1"}
            expect(response).to redirect_to(decks_path)
        end
    end
end

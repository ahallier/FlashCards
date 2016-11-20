require 'spec_helper'
require 'rails_helper'

describe GroupsController, :type => :controller do
    before :each do
        @pub_group = Group.create!({:title => 'Test', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group = Group.create!({:title => 'Test', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now})
        @deck = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true})


    end
    describe 'Visiting index' do 
        it 'should call Group.where' do
            expect(Group).to receive(:where)
            get :index
        end
    end
    
    describe 'Visit add deck page' do 
        it 'should redirect to decks page for non-existent group' do
            get :show_add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to decks page for private group' do
            get :show_add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should render add-deck on success' do
            get :show_add_deck_to_group, {:id => @pub_group.id}
            expect(@request).to render_template('add-deck')
        end
    end
    
    describe 'Adding decks to groups' do
                it 'should redirect to decks page for non-existent group' do
            post :add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to decks page for private group' do
            post :add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should add decks on success' do
            post :add_deck_to_group, {:id => @pub_group.id, :decks => {@deck.id.to_s => '1'}}
            g = Group.find_by_id(@pub_group.id)
            expect(g.decks.any? {|d| d.id == @deck.id}).to be true
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
    describe 'Adding User to Group' do
        it 'should call the Group.addUser method' do
            deck_spy = spy(Group)
            allow(Group).to receive(:find).and_return deck_spy
            expect(deck_spy.UserController).to receive(:create)
            get :group_addUser, {:id => 1}
            expect(response).to redirect_to('/groups')
        end
    end
end

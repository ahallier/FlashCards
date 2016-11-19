require 'spec_helper'
require 'rails_helper'

describe GroupsController, :type => :controller do
    before :each do
        @pub_group = Group.create!({:title => 'Test', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group = Group.create!({:title => 'Test', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now})
        @deck = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true})


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
end

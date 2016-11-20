require 'spec_helper'
require 'rails_helper'

describe GroupsController, :type => :controller do
    before :each do
############################### | ########################################################## | #########################################
############################### V Do not change these! Use them as they are or add your own. V #########################################
        @pub_group = Group.create!({:title => 'Test', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group = Group.create!({:title => 'Test', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now})
        @user = User.create!({
            :email => 'albert@gmail.com', 
            :password => "albert", 
            :session_token => 'abcde',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @pub_group.users << @user
        @pri_group.users << @user
        @user_not_in_group = User.create!({
            :email => 'johncena@gmail.com', 
            :password => "johncena", 
            :session_token => 'abcdeeee',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @deck = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true, :user_id => @user.id})
        @deck2 = Deck.create!({:title => 'Test',  :category => 'TestCat', :public => true, :user_id => @user.id})
        @pub_group.decks << @deck
###############################^ Do not change these! Use them as they are or add your own. ^ #####################################
############################## | ########################################################## | #####################################
    end
    describe 'Visit add deck page' do 
        
        it 'should redirect to decks page if not logged in' do
            get :show_add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to decks page for non-existent group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to group display if there are no decks available' do
            @request.session[:session_token] = @user.session_token
            allow(Deck).to receive(:where).and_return Deck.none
            get :show_add_deck_to_group, {:id => @pub_group.id}
            expect(@request).to redirect_to(group_display_path(@pub_group.id))
        end
        
        it 'should redirect to decks page for private group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should render add-deck on success' do
            @request.session[:session_token] = @user.session_token
            get :show_add_deck_to_group, {:id => @pub_group.id}
            expect(@request).to render_template('add-deck')
        end
    end
    
    describe 'Adding decks to groups' do
        it 'should redirect to decks page for non-existent group' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        

        
        it 'should redirect to decks page for private group' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should add decks on success' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => @pub_group.id, :decks => {@deck2.id.to_s => '1'}}
            g = Group.find_by_id(@pub_group.id)
            expect(g.decks.any? {|d| d.id == @deck.id}).to be true
        end
    end
    
    describe "Removing decks from a group" do
        it 'should redirect to decks path if not logged in' do
            post :remove_deck_from_group, {:group_id => @pub_group.id, :deck_id => @deck.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to decks path if user not in group' do
            @request.session[:session_token] = @user_not_in_group.session_token
            post :remove_deck_from_group, {:group_id => @pub_group.id, :deck_id => @deck.id}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to group display path if user in group' do
            @request.session[:session_token] = @user.session_token
            post :remove_deck_from_group, {:group_id => @pub_group.id, :deck_id => @deck.id}
            expect(@request).to redirect_to(decks_path)
        end
    end
end

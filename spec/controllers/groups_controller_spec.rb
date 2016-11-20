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
    describe 'Visiting index' do 
        it 'should call Group.where' do
            expect(Group).to receive(:where)
            get :index
        end
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
            group_spy = spy(Group)
            @request.session[:session_token] = @user.session_token
            allow(Group).to receive(:find).and_return group_spy
            get :addUser, {:id => 1}
            expect(response).to redirect_to('/groups')
        end
        it 'when user is not logged in' do
            expect(User).to receive(:find_by_session_token)
            get :addUser, {:id => 1}
            expect(response).to redirect_to('/decks')
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
            expect(@request).to redirect_to(group_display_path(@pub_group.id))
        end
    end
    describe 'Adding new public group' do
        it 'should call the Group.create! method' do
            expect(Group).to receive(:create!)
            post :create, {:group =>{:title => 'Test', :public => 'Yes'}}
        end
    end
    describe 'Adding new private group' do
        it 'should call the Group.create! method' do
            expect(Group).to receive(:create!)
            post :create, {:group =>{:title => 'Test', :public => 'No'}}
        end
    end
    describe 'Visiting Group Page' do
        it 'should call Group.find' do
            expect(Group).to receive(:find).and_return(spy(Group))
            get :display, {:id => 1}
        end
    end
end


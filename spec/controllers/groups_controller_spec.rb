require 'spec_helper'
require 'rails_helper'

describe GroupsController, :type => :controller do
    before :each do
        
############################### | ########################################################## | #########################################
############################### V Do not change these! Use them as they are or add your own. V #########################################
        @pub_group = Group.create!({:title => 'Test', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pub_group2 = Group.create!({:title => 'Test', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group = Group.create!({:title => 'Test', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group2 = Group.create!({:title => 'Test', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now})
        @pri_group2.public = false
        @pri_group2.save
        @user = User.create!({
            :email => 'albert@gmail.com', 
            :password => "albert", 
            :session_token => 'user',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @pub_group.users << @user
        @pri_group.users << @user
        @user_not_in_group = User.create!({
            :email => 'johncena@gmail.com', 
            :password => "johncena", 
            :session_token => 'user_not_in_group',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @userA = User.create!({
            :email => 'A@gmail.com', 
            :password => "A", 
            :session_token => 'userA',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @userPriGrp2Owner = User.create!({
            :email => 'B@gmail.com', 
            :password => "B", 
            :session_token => 'userPriGrp2Owner',
            :created_at => DateTime.now,
            :updated_at => DateTime.now
        })
        @pri_group2.owner_id = @userPriGrp2Owner.id
        @pub_group2.users << @user
        @pub_group2.users << @userPriGrp2Owner
        @pub_group2.users << @userA
        @pub_group2.users << @user_not_in_group
        @pub_group2.save
        @pri_group2.save
        
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
        
        it 'should redirect to groups page for private group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should render add-deck on success' do
            @request.session[:session_token] = @user.session_token
            get :show_add_deck_to_group, {:id => @pub_group.id}
            expect(@request).to render_template('add-deck')
        end
    end
    
    describe 'Adding decks to groups' do
        it 'should redirect to decks page if not logged in for get' do
            @request.session[:session_token] = 0
            get :show_add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        it 'should redirect to decks page if not logged in for post' do
            @request.session[:session_token] = 0
            post :add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        it 'should redirect to decks page for non-existent group' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to groups page for private group' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should add decks on success' do
            @request.session[:session_token] = @user.session_token
            post :add_deck_to_group, {:id => @pub_group.id, :decks => {@deck2.id.to_s => '1'}}
            g = Group.find_by_id(@pub_group.id)
            expect(g.decks.any? {|d| d.id == @deck.id}).to be true
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
            @request.session[:session_token] = @user.session_token
            Group.stub(:current_user) { @user }
            group_spy = spy(Group)
            expect(Group).to receive(:create!).and_return(group_spy)
            expect(group_spy).to receive(:users)
            post :create, {:group =>{:title => 'Test', :public => 'Yes'}}
        end
    end
    describe 'Adding new group without login' do
        it 'should redirect to decks' do
            @request.session[:session_token] = nil
            post :create, {:group =>{:title => 'Test', :public => 'Yes'}}
            expect(@request).to redirect_to(decks_path)
        end
    end
    describe 'Adding new private group' do
        it 'should call the Group.create! method' do
            @request.session[:session_token] = @user.session_token
            group_spy = spy(Group)
            expect(Group).to receive(:create!).and_return(group_spy)
            expect(group_spy).to receive(:users)
            post :create, {:group =>{:title => 'Test', :public => 'No'}}
        end
    end
    describe 'Visiting Group Page' do
        it 'should call Group.find' do
            expect(Group).to receive(:find).and_return(spy(Group))
            get :display, {:id => 1}
        end
    end
    
    describe 'Visit add user page' do 
        
        it 'should redirect to decks page if not logged in' do
            @request.session[:session_token] = 0
            get :show_add_user_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to decks page for non-existent group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_user_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end 
        
        it 'should redirect to group path if there are no users available' do
            @request.session[:session_token] = @user.session_token
            #pub group 2 has all users added already
            allow(User).to receive(:all).and_return(nil)
            get :show_add_user_to_group, {:id => @pub_group2.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should redirect to groups page for private group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_user_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should redirect to groups page for private group where user is not owner' do
            @request.session[:session_token] = @user.session_token
            get :show_add_user_to_group, {:id => @pri_group.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should redirect to groups page for public group' do
            @request.session[:session_token] = @user.session_token
            get :show_add_user_to_group, {:id => @pub_group.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should render add-user on success when current_user is owner and deck is private' do
            puts 'should render add-user on success when current_user is owner and deck is private'
            puts "\tTest - Group is public? #{@pri_group2.public}"
            puts "\tTest - Group owner Id: #{@pri_group2.owner_id}"
            puts "\tTest - User Id: #{@userPriGrp2Owner.id}"
            @request.session[:session_token] = @userPriGrp2Owner.session_token
            get :show_add_user_to_group, {:id => @pri_group2.id}
            expect(@request).to render_template('add-user')
        end
    end
    
    describe 'Adding users to groups' do
        it 'should redirect to decks page for non-existent group' do
            @request.session[:session_token] = @user.session_token
            post :add_user_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
    it 'should redirect to decks page if not logged in' do
            @request.session[:session_token] = 0
            get :add_user_to_group, {:id => 99123492}
            expect(@request).to redirect_to(decks_path)
        end
        
        it 'should redirect to groups page for private group' do
            @request.session[:session_token] = @user.session_token
            post :add_user_to_group, {:id => @pri_group2.id}
            expect(@request).to redirect_to(groups_path)
        end
        
        it 'should add users on success' do
            @request.session[:session_token] = @userPriGrp2Owner.session_token
            post :add_user_to_group, {:id => @pri_group2.id, :users => {@user.id.to_s => '1'}}
            #expect(@request).to redirect_to(groups_path)
            g = Group.find_by_id(@pri_group2.id)
            expect(g.users.any? {|d| d.id == @user.id}).to be true
        end
    end
    
end


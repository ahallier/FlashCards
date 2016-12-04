class UsersController < ApplicationController
    before_filter :set_current_user
  def users_params
   
    params.require(:user).permit(:email, :password, :session_token, :user_id)
  end

  def index
      @decks = @current_user.decks
  end
  
  def new
    # default: render 'new' template
  end
   def create
    @user = User.create_user!(params) 
    
    if @user == "user exists"
      
      flash[:notice] = "This email is already being used. Please use another ID"
      redirect_to new_user_path
    else
      flash[:notice] = "Account was created sucessfully "
       redirect_to login_path
    end
   
   
   end
   
  def edit
    @user = User.find(params[:id])
  end
 
 def update
   @user = User.find_by_id(params[:id])
   @user.update_attributes(users_params)
   flash[:notice] = "Account was edited sucessfully "
   redirect_to decks_path
end
 
 
end

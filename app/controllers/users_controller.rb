class UsersController < ApplicationController

  def users_params
   
    params.require(:user).permit(:email, :password,:session_token)
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
 
end
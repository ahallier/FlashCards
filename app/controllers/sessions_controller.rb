class SessionsController < ApplicationController
  def new
    # default: render 'new' template
  end

  def create
    if(User.exists?(:email => params[:session][:email]))
      user = User.find_by(email: params[:session][:email])
      puts("user exists")
    
    else
      puts "not user exists"
      redirect_to new_user_path and return 
      
    end
  
    session[:session_token] = user.session_token
      if user && params[:session][:email] == user.email && params[:session][:password] == user.password
          redirect_to decks_path
      else 
        flash[:warning] = "incorrect Password"
        redirect_to login_path
      end
  end
  def destroy
    reset_session
    redirect_to decks_path
  end
end
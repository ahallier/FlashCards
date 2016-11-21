class SessionsController < ApplicationController
  def new
    # default: render 'new' template
  end

  def create
  
    user = User.find_by(email: params[:session][:email])
    session[:session_token] = user.session_token
    if user && params[:session][:email] == user.email && params[:session][:password] == user.password
        redirect_to decks_path
    end
    else 
      flash[:warning] = "incorrect Email / Password"
      redirect_to login_path
    end
  end
  def destroy
    reset_session
    redirect_to decks_path
  end
    
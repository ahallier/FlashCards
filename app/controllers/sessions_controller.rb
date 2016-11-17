class SessionsController < ApplicationController
  def new
    # default: render 'new' template
  end

  def create
    
    user = User.find_by(email: params[:session][:email])
    session[:session_token] = user.session_token
    if user && params[:session][:email] == user.email
      @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
      redirect_to decks_path
    else 
      flash[:warning] = "incorrect User Email"
      redirect_to login_path
    end
  end
  def destroy
    reset_session
    redirect_to decks_path
  end
    
end
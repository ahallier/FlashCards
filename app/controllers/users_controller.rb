class UsersController < ApplicationController
    before_filter :set_current_user
    
  def users_params
    params.require(:user).permit(:email, :password, :session_token, :user_id)
  end

  def index
    sort = params[:sort] || session[:sort]
    if sort == nil
      #asc_or_desc = session[:ascending] ? 'asc' : 'desc'
      #ordering = 'lower('+sort+') '+ asc_or_desc
      #@decks = Deck.search(params[:search]).where(public: true).order(ordering)
      @decks = @current_user.decks
      @groups = @current_user.groups
      render 'index' and return
    end
        
    if params[:sort] != session[:sort]
      # switch ascending and descending if the user clicks on the header multiple times
      session[:ascending] = true
      session[:sort] = sort
      #redirect_to :sort => sort and return
    elsif params[:random] == session[:random]
      # if the random token is new and the sort parameter is the same as the sort session token
      # that means that the user clicked on the same header they did last time so we reverse the
      # ordering. If the random token is different, that means the user just refreshed the page and
      # we don't want to reverse the ordering.
      session[:ascending] = !session[:ascending]
    end
        
    asc_or_desc = session[:ascending] ? 'asc' : 'desc'
        
    # the call to lower() make the search case insensitive
    #ordering = 'lower('+sort+') '+ asc_or_desc

    @decks = @current_user.decks.search(params[:search]).order('lower('+sort+') '+ asc_or_desc)
    #@decks = @decks.paginate(:page => params[:page], :per_page => 5)
    
    puts 'SPAGETT'
    puts @current_user.groups
    
    @groups = @current_user.groups
        
    # the random token is used to ensure that the ordering doesn't get reversed on page refresh.
    @random = SecureRandom.uuid
    session[:random] = @random
    render 'index' and return
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

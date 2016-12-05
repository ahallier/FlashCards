module ApplicationHelper
    
  def is_group_owner?(group)
    @current_user = User.find_by_session_token(session[:session_token])
    return ture if group.where(:owner_id => @current_user.id).exist
  end
  def is_public?(group)
    return true if group.public == true
  end
end

module ApplicationHelper
  def authenticated?
    session[:user_id]
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_name
  def index
      @title = "WhereIGo"
      render layout: false
  end
  
  def user_name
    user = User.find_by(id: session[:current_user_id])
    return user.name
  end
  
end
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index
      @title = "WhereIGo"
      render layout: false
  end
  
end
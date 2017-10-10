class DashboardController < ApplicationController
    def index
        @title = "Dashboard"
        @username = User.find_by_id(session[:current_user_id]).name
    end
    
end

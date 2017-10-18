class DashboardController < ApplicationController
    def index
        @title = "Dashboard"
        user = User.find_by(id: session[:current_user_id])
        @username = user.name
    end
    
end

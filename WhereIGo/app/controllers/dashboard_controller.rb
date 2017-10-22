class DashboardController < ApplicationController
    def index
        @title = "Dashboard"
        @places = Establishment.all
    end
    
end

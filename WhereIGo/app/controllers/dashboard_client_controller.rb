class DashboardClientController < ApplicationController
    
    def index
        @title = "Dashboard"
        @establishments = Establishment.all
        render layout: "client"
    end
    
    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        render layout: "client"
    end
    
end

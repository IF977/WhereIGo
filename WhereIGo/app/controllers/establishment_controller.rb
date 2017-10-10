class EstablishmentController < ApplicationController
    def index
        @title = "Meus estabelecimentos"
        user = User.find_by(id: session[:current_user_id])
        @establishments = Establishment.all
    end
    
    def new
        @title = "Novo estabelecimento"
    end
    
    def create
        user = User.find_by(id: session[:current_user_id])
        values = params.require(:establishment).permit!
        if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
            render 'error'
            return
        else
            user.establishments.create values
            redirect_to '/establishments'
        end
    end
    
    def show
        @e = Establishment.find(params[:id])
    end
    
    def update
        values = params.require(:establishment).permit!
        Establishment.update(session[:current_user_id], values)
    end
    
    private
    def establishment_params
        params.require(:establishment).permit(:cnpj, :name, :address, :email, :website)
    end
end

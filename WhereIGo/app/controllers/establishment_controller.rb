class EstablishmentController < ApplicationController
    def index
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
    end
    
    def new
        @title = "Novo estabelecimento"
    end
    
    def create
        values = params.require(:establishment).permit!
        if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
            render 'error'
            return
        else
            new_establishment = Establishment.create values
            Establishment.update(new_establishment[:id], :user_id => session[:current_user_id])
            redirect_to '/establishments'
            return
        end
    end
    
    def show
        @establishments = Establishment.find_by(id: params[:id])
    end
    
    def update
        values = params.require(:establishment).permit!
        Establishment.update(params[:id], values)
        redirect_to '/establishments'
    end
    
    #private
    #def establishment_params
    #    params.require(:establishment).permit(:cnpj, :name, :address, :email, :website)
    #end
end

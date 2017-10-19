class EstablishmentController < ApplicationController
    
    def flash_create_user(message)
        session[:return_to] ||= request.referer
    	redirect_to session.delete(:return_to), :flash => {:error => message}
    	return
    end
    
    def index
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
    end
    
    def new
        @title = "Novo estabelecimento"
    end
    
    def create
        values = params.require(:establishment).permit!
        new_establishment = Establishment.new values
        if new_establishment.valid?
            if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
                flash_create_user("CNPJ já está em uso.")
    		    return
    		else
    		    new_establishment.update_attributes(:user_id => session[:current_user_id])
    		    new_establishment.save!
                redirect_to '/establishments'
                return
            end
        else
            if params[:establishment][:name].strip == ""
                flash_create_user("O campo nome é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:email] == ""
    		    flash_create_user("O campo e-mail é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:cnpj].size != 14
    		    flash_create_user("O CNPJ precisa ter 14 caracteres.")
    		    return
    		
    		elsif params[:establishment][:address].strip == ""
    		    flash_create_user("O campo endereço é obrigatório.")
    		    return
    		end
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

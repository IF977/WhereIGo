class EstablishmentController < ApplicationController
    include ActionView::Helpers::UrlHelper #current_page?()
    
    def flash_create_user(message)
        if current_page?('/register/provider/establishment')
    	   redirect_to '/register/provider/establishment', :flash => {:error => message}
    	   return
    	else
    	   redirect_to '/register/provider/establishment', :flash => {:error => message}
    	   return
    	end
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
                redirect_to '/login', :flash => { :error => "CNPJ já está em uso." }
    		    return
    		else
    		    new_establishment.save
    		    new_establishment.update_attributes(:user_id => session[:current_user_id])
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

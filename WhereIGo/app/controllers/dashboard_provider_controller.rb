class DashboardProviderController < ApplicationController
    
    def flash_create_user(message)
        session[:return_to] ||= request.referer
    	redirect_to session.delete(:return_to), :flash => {:error => message}
    	return
    end
    
    def new_establishment
        @title = "Novo estabelecimento"
        render layout: "provider"
    end
    
    def create_establishment
        values = params.require(:establishment).permit!
        new_establishment = Establishment.new values
        if new_establishment.valid?
            if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
                flash_create_user("CNPJ já está em uso.")
    		    return
    		else
    		    new_establishment.update_attributes(:user_id => session[:current_user_id])
    		    new_establishment.save!
                redirect_to '/p/my_establishments'
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
    
    def my_establishments
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
        render layout: "provider"
    end

    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        render layout: "provider"
    end
    
    def edit_establishment
        @establishments = Establishment.find_by(id: params[:id])
        render layout: "provider"
    end
    
    def update_establishment
        values = params.require(:establishment).permit!
        Establishment.update(params[:id], values)
        redirect_to '/p/my_establishments'
    end
    
end

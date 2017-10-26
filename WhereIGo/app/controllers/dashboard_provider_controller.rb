class DashboardProviderController < ApplicationController
    
    def flash_message(message)
        session[:return_to] ||= request.referer
    	redirect_to session.delete(:return_to), :flash => {:error => message}
    	return
    end
    
    def user_is_authorized_?
        if session[:current_user_id] == nil
            redirect_to({:controller =>'account', :action => 'login'}, :flash => {:error => "Faça login para continuar!"})  and return false
        else
            user_logged = User.find(session[:current_user_id])
            if user_logged.is_provider != true
                redirect_to({:controller =>'dashboard_client', :action => 'all_establishments'}, :flash => {:error => "O usuário não possui um perfil cliente."}) and return false
            end
            return true
        end
    end
    
    def new_establishment
        
        @title = "Novo estabelecimento"
        
        if user_is_authorized_?()
            render layout: "provider"
        end
        
    end
    
    def create_establishment
        
        values = params.require(:establishment).permit!

        new_establishment = Establishment.new values
        if new_establishment.valid?
            if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
                flash_message("CNPJ já está em uso.")
    		    return
    		else
    		    new_establishment.update_attributes(:user_id => session[:current_user_id])
    		    new_establishment.save!
                redirect_to '/p/my_establishments'
                return
            end
        else
            if params[:establishment][:name].strip == ""
                flash_message("O campo nome é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:email] == ""
    		    flash_message("O campo e-mail é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:cnpj].size != 14
    		    flash_message("CNPJ inválido.")
    		    return
    		
    		elsif params[:establishment][:address].strip == ""
    		    flash_message("O campo endereço é obrigatório.")
    		    return
    	    end
        end
    end
    
    def my_establishments
        
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
        
        if user_is_authorized_?()
            render layout: "provider"
        end
    end

    def show_establishment
        
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        
        if user_is_authorized_?()
            render layout: "provider"
        end
        
    end
    
    def edit_establishment
        
        @establishments = Establishment.find_by(id: params[:id])
        
        if user_is_authorized_?()
            render layout: "provider"
        end
        
    end
    
    def update_establishment
        
        values = params.require(:establishment).permit!
        
        update_establishment = Establishment.new values
        if not update_establishment.valid?
            if params[:establishment][:name].strip == ""
                flash_message("O campo nome é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:email] == ""
    		    flash_message("O campo e-mail é obrigatório.")
    		    return
    		    
    		elsif params[:establishment][:cnpj].size != 14
    		    flash_message("CNPJ inválido.")
    		    return
    		
    		elsif params[:establishment][:address].strip == ""
    		    flash_message("O campo endereço é obrigatório.")
    		    return
    	    end
        else
            Establishment.update(params[:id], values)
            redirect_to '/p/my_establishments'
        end
    end
    
end

class DashboardClientController < ApplicationController
    
    def flash_message(message)
        session[:return_to] ||= request.referer
    	redirect_to session.delete(:return_to), :flash => {:error => message}
    	return
    end
    
    def user_is_authorized_?
        if session[:current_user_id] == nil
            redirect_to({:controller =>'account', :action => 'login'}, :flash => {:error => "Faça login para continuar!"})  and return false
        else
            user_logged = User.find_by(id: session[:current_user_id])
            if user_logged.is_client != true
                redirect_to({:controller =>'dashboard_provider', :action => 'my_establishments'}, :flash => {:error => "O usuário não possui um perfil de dono de estabelecimento."}) and return false
            end
            return true
        end
    end
    
    
    def all_establishments
        @title = "Dashboard"
        @establishments = Establishment.all
        
        if user_is_authorized_?
            render layout: "client"
        end
    end
    
    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        
        if user_is_authorized_?
            render layout: "client"
        end
        
    end
    
end

class AccountController < ApplicationController
    include ActionView::Helpers::UrlHelper #current_page?()
    
    def flash_create_user(message)
        if current_page?('/register/client')
    	   redirect_to '/register', :flash => {:error => message}
    	   return
    	else
    	   redirect_to '/register', :flash => {:error => message}
    	   return
    	end
    end
    
    def edit
        @title = "Minha conta"
        if session[:current_user_id] == nil
            redirect_to '/login', :flash => { :error => "Faça login para continuar!" }
            return
        end
        @user = User.find_by(id: session[:current_user_id])
    end
    
    def update
        values = params.require(:user).permit!
        User.update(session[:current_user_id], values)
    end
    
    def login
    	if session[:current_user_id] != nil
    		redirect_to '/account', :flash => { :error => "Você já está logado!" }
    		return
    	end
    	@title = "Login"
    	render layout: "login-signup"
    end
    
    def login_authentication
    	user = User.find_by(email: params["email"])
    	if user != nil
    		if user.password_digest == params["password"]
    		    session[:current_user_id] = user.id
    			if user.is_client or user.is_provider
    			    redirect_to '/dashboard'
    			    return
    			else
    			    redirect_to '/register/role'
    		    	return
    		    end
    		else
    			redirect_to '/login', :flash => { :error => "Usuário ou senha incorretas!" }
    			return
    		end
    	else
    		redirect_to '/login', :flash => { :error => "Usuário não encontrado!" }
    		return
    	end
    end
    
    def logout
    	session[:current_user_id] = nil
	    redirect_to '/login', :flash => { :error => "Desconectado." }
	    return
    end
    
    def register_account
        @title = "Cadastro"
        render layout: "login-signup"
    end
    
    def register_create_account
        values = params.require(:user).permit!
        if params[:user][:password_digest] == params["confirmation-password"]
            if params[:user][:name].strip == ""
                flash_create_user("O campo nome é obrigatório")
                return
            elsif params[:user][:email].strip == ""
                flash_create_user("O campo e-mail é obrigatório")
                return
            elsif User.exists?(:email => params[:user][:email])
                flash_create_user("O email já está em uso.")
                return
            elsif params[:user][:password_digest].strip == ""
                flash_create_user("O campo senha não pode ter espaço.")
                return
            else
    	        new_user = User.create values
    	        if new_user.valid?
    	            session[:current_user_id] = new_user[:id]
    	            redirect_to '/register/role'
    	            return
    	        else
                    flash_create_user("O campo nome não pode ter números ou caracteres especiais!")
                    return
                end
    	    end
    	else
    	    flash_create_user("As senhas são diferentes.")
    	    return
    	end
    	render layout: "login-signup"
    end
    
    def register_role_choice
        render layout: "login-signup"
    end
    
    
    def register_role_provider
        User.update(session[:current_user_id], :is_provider => true)
        redirect_to '/register/provider/establishment'

    end
    
    def register_role_client
        User.update(session[:current_user_id], :is_client => true)
        redirect_to '/dashboard'
    end
    
    def register_provider_establishment
        @title = "Estabelecimento"
        render layout: "login-signup"
    end
    
    def register_client_preferences
        @title = "Preferencias"
        render layout: "login-signup"
    end
    
end

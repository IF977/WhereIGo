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
    			redirect_to '/dashboard'
    			return
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
            if User.exists?(:email => params[:user][:email])
                flash_create_user("O email já está em uso.")
                return
            else
    	        new_user = User.create values
    	        session[:current_user_id] = new_user[:id]
    	        redirect_to '/register/role'
    	        return
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
        redirect_to '/establishments/new'
    end
    
    def register_role_client
        User.update(session[:current_user_id], :is_client => true)
    end
    
end

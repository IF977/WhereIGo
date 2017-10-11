class AccountController < ApplicationController
    include ActionView::Helpers::UrlHelper #current_page?()
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
    
    def register_role_choice
        render layout: "login-signup"
    end
    
    def register_client
        @title = "Cadastro"
        render layout: "login-signup"
    end
    
    def register_provider
        @title = "Cadastro"
        render layout: "login-signup"
    end
    
    def flash_create_user(message)
        if current_page?('/register/client')
    	   redirect_to '/register/client', :flash => {:error => message}
    	   return
    	else
    	   redirect_to '/register/provider', :flash => {:error => message}
    	   return
    	end
    end
    
    def register_create_user
                values = params.require(:user).permit!
        if params[:user][:password_digest] == params["confirmation-password"]
            if User.exists?(:email => params[:user][:email])
                flash_create_user("O email já está em uso.")
                return
            else
                if params[:user][:is_provider] == "Yes"
                    params[:user][:is_provider] = true
    	            User.create values
    	        else
    	            params[:user][:is_provider] = false
    	            User.create values
    	        end
    	        redirect_to '/login', :flash => {:notice => "Conta criada com sucesso!"}
    	        return
    	    end
    	else
    	    flash_create_user("As senhas são diferentes.")
    	    return
    	end
    	render layout: "login-signup"
    end
    
end

class RegisterController < ApplicationController
    include ActionView::Helpers::UrlHelper #current_page?()
    def new
        render layout: "login-signup"
    end
    
    def new_client
        @title = "Cadastro"
        render layout: "login-signup"
    end

    def new_provider
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
    
    def create
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
    def error
    end

end

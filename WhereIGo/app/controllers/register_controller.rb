class RegisterController < ApplicationController
    def new
        render layout: "login-signup"
    end
    
    def new_client
        render layout: "login-signup"
        @title = "Cadastro"
    end

    def new_provider
        render layout: "login-signup"
        @title = "Cadastro"
    end
    
    def create
        #render layout: "login-signup"
        values = params.require(:user).permit!
        if params[:user][:password_digest] == params["confirmation-password"]
            if User.exists?(:email => params[:user][:email])
                render 'error'
            else
                if params[:user][:is_provider] == "Yes"
                    params[:user][:is_provider] = true
    	            User.create values
    	        else
    	            params[:user][:is_provider] = false
    	            User.create values
    	        end
    	    end
    	else

    	    redirect_to '/register', :flash => {:error => "Teste"}
    	    #render 'error'
    	end
    end
    
    def error
    end

end

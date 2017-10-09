class RegisterController < ApplicationController
    def new
    end
    
    def new_client
        @title = "Cadastro"
    end

    def new_provider
        @title = "Cadastro"
    end

    def create
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
    	    render 'error'
    	end
    end
    
    def error
    end

end

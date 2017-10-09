class RegisterController < ApplicationController
    def new
    end
    
    def new_client
    end

    def new_provider
    end

    def create_client
        values = params.require(:client).permit!
        if params[:client][:password_digest] == params["confirmation-password"]
            if Client.exists?(:email => params[:client][:email])
                render 'error'
            else
    	        Client.create values
    	    end
    	else
    	    render 'error'
    	end
    end

    def create_provider
        values = params.require(:provider).permit!
        if params[:provider][:password_digest] == params["confirmation-password"]
            if Provider.exists?(:email => params[:provider][:email])
                render 'error'
            else
                Provider.create values
            end
        else
            render 'error'
        end
    end
    
    def error
    end

end

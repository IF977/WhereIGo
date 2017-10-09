class SessionsController < ApplicationController

def new
	if session[:current_user_id] != nil
		render 'success'
	end
end

def create
	user_client = Client.find_by(email: params["email"])
	user_provider = Provider.find_by(email: params["email"])
	if user_client != nil or user_provider!= nil
		if user_client != nil
			if user_client.password_digest == params["password"]
				session[:current_user_id] = user_client.id
				render 'success'
			else
				render 'error'
			end
		else
			if user_provider.password_digest == params["password"]
				session[:current_user_id] = user_provider.id
				render 'success'
			else
				render 'error'
			end
		end    
	else
		#flash[:error] = "Usuário ou senha incorretas!"
	end
end


def success
end

def error
end

def destroy
	session[:current_user_id] = nil
end

end

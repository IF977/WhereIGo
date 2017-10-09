class SessionsController < ApplicationController
include ApplicationHelper
def new
	@title = "Login"
	if session[:current_user_id] != nil
	end
end

def create
	@title = "Login"
	user_client = User.find_by(email: params["email"])
	if user_client != nil
		if user_client.password_digest == params["password"]
			session[:current_user_id] = user_client.id
		else
			#render 'error'
			redirect_to '/login', :flash => { :error => "Usuário ou senha incorretas!" }
		end
	else
		#render 'error'
		redirect_to '/login', :flash => { :error => "Usuário não encontrado!" }
	end
end

def error
end

def destroy
	session[:current_user_id] = nil
end

end

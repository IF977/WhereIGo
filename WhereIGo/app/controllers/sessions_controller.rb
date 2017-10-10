class SessionsController < ApplicationController
def new
	if session[:current_user_id] != nil
		redirect_to '/account', :flash => { :error => "Você já está logado!" }
		return
	end
	@title = "Login"
	render layout: "login-signup"
end

def create
	@title = "Login"
	user = User.find_by(email: params["email"])
	if user != nil
		if user.password_digest == params["password"]
			session[:current_user_id] = user.id
			redirect_to '/account'
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

def error
end

def destroy
	session[:current_user_id] = nil
end

end

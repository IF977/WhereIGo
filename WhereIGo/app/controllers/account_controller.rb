class AccountController < ApplicationController
    
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
    
end

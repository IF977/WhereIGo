class AccountController < ApplicationController
    
    helper_method :user_logged
        
    def user_logged
        if session[:current_user_id] != nil
            user = User.find_by(id: session[:current_user_id])
            return user
        end
        return nil
    end
    
    def flash_message(message)
        session[:return_to] ||= request.referer
    	redirect_to session.delete(:return_to), :flash => {:error => message}
    	return
    end
    
    
    def flash_message_special(message)
        redirect_to({:action => 'register_account'}, :flash => {:error => message})
    	return
    end
    
    def user_is_authorized_?
        if user_logged() == nil
            redirect_to({:action => 'login'}, :flash => {:error => "Faça login para continuar!"})  and return false
        end
        return true
    end
    
    def edit
        @title = "Minha conta"
        if user_is_authorized_?
            @user = user_logged
            render layout: "dashboard"
        end
    end
    
    def update
        values = params.require(:user).permit!
        user = User.find_by(email: params[:user][:email])
        if params[:user][:password_digest] == user.password_digest
            User.update(session[:current_user_id], values)
            uploader = ImageUploader.new
            uploader.store!(values[:image])
            flash_message("Conta editada com sucesso!")
        else
            flash_message("Senha incorreta.")
        end
    end
    
    def login
    	if session[:current_user_id] != nil
    		redirect_to({:controller => 'dashboard', :action => 'all_establishments'}) 
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
    	        redirect_to({:controller => 'dashboard', :action => 'all_establishments'}) 
    	        return
    		else
    		    flash_message("Usuário ou senha incorretas!")
    			return
    		end
    	else
    	    flash_message("Usuário não encontrado!")
    		return
    	end
    end
    
    def logout
    	session[:current_user_id] = nil
	    redirect_to :action => 'login'
	    return
    end
    
    def register_account
        @title = "Cadastro"
        render layout: "login-signup"
    end
    
    def register_create_account
        values = params.require(:user).permit!
        new_user = User.new values
        if new_user.valid?
            if User.exists?(:email => params[:user][:email])
                flash_message_special("O email já está em uso.")
                return
            else
                new_user.save
        	    session[:current_user_id] = new_user[:id]
        	    redirect_to :action => 'register_profile_choice'
        	    return
            end
        else
            if params[:user][:name].strip == ""
                flash_message_special("O campo nome é obrigatório.")
                return
            elsif params[:user][:email].strip == ""
                flash_message_special("O campo e-mail é obrigatório.")
                return
            elsif params[:user][:password_digest].size < 6
        	    flash_message_special("A senha precisa ter no mínimo 6 caracteres.")
        	    return
            elsif params[:user][:password_digest].strip == ""
                flash_message_special("O campo senha não pode ter espaço.")
                return
            end
        end
    	render layout: "login-signup"
    end
    
    def register_profile_choice
        if user_is_authorized_?
            render layout: "login-signup"
        end
    end
    
    
    def register_profile_provider
        User.update(session[:current_user_id], :is_provider => true)
        redirect_to :action => 'register_provider_establishment'
    end
    
    def register_profile_client
        redirect_to :action => 'register_c_preferences_music'
    end
    
    def register_c_preferences_music
        if user_is_authorized_?
            @title = "Preferências: Música"
            musics = Music.all
            
            hash_musics = {}
            
            musics.each do |m|
                hash_musics[m.id] = m.name
            end
            
            @checkboxes = hash_musics
            
            render layout: "pref"
        end
    end
    
    def register_c_preferences_music_create
        begin
            musics = params["music"]["genre"]
        rescue
            musics = nil
        end
        user_id = session[:current_user_id]
        if musics != nil
            musics.each do |m|
                if MusicPreference.exists?(:user_id=>user_id,:music_id=>m.to_i)
                    redirect_to :action => 'register_c_preferences_ambient'
                else
                    new_preference = MusicPreference.new ({:music_id => m.to_i, :user_id => user_id})
                    new_preference.save
                end
            end
        end
         redirect_to :action => 'register_c_preferences_ambient'
    end
    
    def register_c_preferences_ambient
        if user_is_authorized_?
            @title = "Preferencias de Ambiente"
            ambients = Ambient.all
            
            hash_ambient = {}
            
            ambients.each do |a|
                hash_ambient[a.id] = a.name
            end
            
            @checkboxes = hash_ambient
            
            render layout: "pref"
        end
    end
    
    def register_c_preferences_ambient_create
        begin
            ambients = params["ambient"]["type"]
        rescue
            ambients = nil
        end
        user_id = session[:current_user_id]
        if ambients != nil
            ambients.each do |a|
                if AmbientPreference.exists?(:user_id=>user_id,:ambient_id=>a.to_i)
                    redirect_to :action => 'register_c_preferences_food'
                else
                    new_preference = AmbientPreference.new ({:ambient_id => a.to_i, :user_id => user_id})
                    new_preference.save
                end
            end
        end
        redirect_to :action => 'register_c_preferences_food'
    end
    
    def register_c_preferences_food
        if user_is_authorized_?
            @title = "Preferencias Gastronômicas"
            
            foods = Food.all
            
            hash_foods = {}
            
            foods.each do |f|
                hash_foods[f.id] = f.name
            end
            
            @checkboxes = hash_foods
            
            render layout: "pref"
        end
        
    end
    
    def register_c_preferences_food_create
        begin
            foods = params["food"]["type"]
        rescue
            foods = nil
        end
        user_id = session[:current_user_id]
        if foods != nil
            foods.each do |c|
                if FoodPreference.exists?(:user_id =>user_id, :food_id => c.to_i)
                     redirect_to({:controller => 'dashboard', :action => 'all_establishments'})
                     return
                else
                    new_preference = FoodPreference.new ({:food_id => c.to_i, :user_id => user_id})
                    new_preference.save
                end
            end
        end
        redirect_to({:controller => 'dashboard', :action => 'all_establishments'})
    end
    
    
    
    def register_provider_establishment
        @title = "Estabelecimento"
        if user_is_authorized_?
            user = User.find_by(id: session[:current_user_id])
            if user.is_provider = 't' 
                render layout: "login-signup"
            end
        end
    end
    
    def register_provider_establishment_create
        values = params.require(:establishment).permit!
        new_establishment = Establishment.new values
        if new_establishment.valid?
    		new_establishment.update_attributes(:user_id => session[:current_user_id])
    		new_establishment.save!
    		$establishment_id = new_establishment.id
            redirect_to :action => 'register_p_speciality_music'
            return
        else
            if params[:establishment][:name].strip == ""
                flash_message("O campo nome é obrigatório.")
    		    return
    		elsif params[:establishment][:address].strip == ""
    		    flash_message("O campo endereço é obrigatório.")
    		    return
    	    end
        end
    end
    
    def register_p_speciality_music
        if user_is_authorized_?
            @title = "Especialidade: Música"
            musics = Music.all
            
            hash_musics = {}
            
            musics.each do |m|
                hash_musics[m.id] = m.name
            end
            
            @checkboxes = hash_musics
            
            render layout: "pref"
        end
    end
    
    def register_p_speciality_music_create
        begin
            musics = params["music"]["genre"]
        rescue
            musics = nil
        end
        establishment_id = $establishment_id
        if musics != nil
            musics.each do |m|
                if MusicSpeciality.exists?(:establishment_id => establishment_id,:music_id => m.to_i)
                    redirect_to :action => 'register_p_speciality_ambient'
                else
                    new_speciality = MusicSpeciality.new ({:music_id => m.to_i, :establishment_id => establishment_id})
                    new_speciality.save
                end
            end
        end
         redirect_to :action => 'register_p_speciality_ambient'
    end
    
    def register_p_speciality_ambient
        if user_is_authorized_?
            @title = "Especialidade: Ambiente"
            ambients = Ambient.all
            
            hash_ambients = {}
            
            ambients.each do |m|
                hash_ambients[m.id] = m.name
            end
            
            @checkboxes = hash_ambients
            
            render layout: "pref"
        end
    end
    
    def register_p_speciality_ambient_create
        begin
            ambients = params["ambient"]["type"]
        rescue
            ambients = nil
        end
        establishment_id = $establishment_id
        if ambients != nil
            ambients.each do |a|
                if AmbientSpeciality.exists?(:establishment_id => establishment_id,:ambient_id => a.to_i)
                    redirect_to :action => 'register_p_speciality_food'
                else
                    new_speciality = AmbientSpeciality.new ({:ambient_id => a.to_i, :establishment_id => establishment_id})
                    new_speciality.save
                end
            end
        end
        redirect_to :action => 'register_p_speciality_food'
    end
    
    
        
    def register_p_speciality_food
       if user_is_authorized_?
            @title = "Especialidade: Ambiente"
            foods = Food.all
            
            hash_foods = {}
            
            foods.each do |m|
                hash_foods[m.id] = m.name
            end
            
            @checkboxes = hash_foods
            
            render layout: "pref"
        end
    end
    
    def register_p_speciality_food_create
        begin
            foods = params["food"]["type"]
        rescue
            foods = nil
        end
        establishment_id = $establishment_id
        if foods != nil
            foods.each do |f|
                if FoodSpeciality.exists?(:establishment_id => establishment_id,:food_id => f.to_i)
                    redirect_to({:controller => 'dashboard', :action => 'all_establishments'})
                    return
                else
                    new_speciality = FoodSpeciality.new ({:food_id => f.to_i, :establishment_id => establishment_id})
                    new_speciality.save
                end
            end
        end
        redirect_to({:controller => 'dashboard', :action => 'all_establishments'})
    end
    
    
    def add_provider_profile
        user_id = session[:current_user_id]
        User.update(user_id, :is_provider => true)
        redirect_to({:controller => 'dashboard', :action => 'my_establishments'})
    end
    
end
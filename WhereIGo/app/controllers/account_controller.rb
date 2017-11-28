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
    		redirect_to({:controller => 'dashboard', :action => 'preference_establishments_result'}) 
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
    	        redirect_to({:controller => 'dashboard', :action => 'preference_establishments_result'}) 
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
                uploader = ImageUploader.new
                uploader.store!(values[:image])
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
        redirect_to :action => 'register_preferences_music'
    end
    
    def register_preferences_music
        if user_is_authorized_?
            @title = "Preferências: Música"
            musics = Music.all
            
            hash_musics = {}
            
            musics.each do |m|
                hash_musics[m.id] = m.name, MusicPreference.exists?(:user_id=> user_logged.id,:music_id=>m.id, :is_active => true)
            end
            
            @checkboxes = hash_musics
            
            render layout: "pref"
        end
    end
    
    def register_preferences_music_create
        begin
            musics = params["music"]
        rescue
            musics = nil
        end
        
        user_music_preference_query = MusicPreference.where(:user_id => user_logged.id)
        
        user_music_preference = []
        user_music = []
        user_music_preference_query.each do |q|
            user_music << q.music_id
            user_music_preference << q.id
		end
        
	user_music_preference_copy = user_music_preference.clone
	
        user_id = user_logged.id
        
        if musics != nil
            musics.each do |m|
                m = m.to_i
                if not user_music.include?(m)
                    new_preference = MusicPreference.new ({:music_id => m, :user_id => user_id})
                    new_preference.save
                else
                    index = user_music.index(m)
                    MusicPreference.update(user_music_preference_copy[index], :is_active => true)
                    user_music_preference.delete_at(index)
                end
            end
        end
        
        user_music_preference.each do |u|
            MusicPreference.update(u, :is_active => false)
        end
        
         redirect_to :action => 'register_preferences_ambient'
    end
    
    def register_preferences_ambient
        if user_is_authorized_?
            @title = "Preferencias de Ambiente"
            ambients = Ambient.all
            
            hash_ambient = {}
            
            ambients.each do |a|
                hash_ambient[a.id] = a.name, AmbientPreference.exists?(:user_id=>user_logged.id,:ambient_id=>a.id, :is_active => true)
            end
            
            @checkboxes = hash_ambient
            
            render layout: "pref"
        end
    end
    
    def register_preferences_ambient_create
        begin
            ambients = params["ambient"]
        rescue
            ambients = nil
        end
        
        user_ambient_preference_query = AmbientPreference.where(:user_id => user_logged.id)
        
        user_ambient_preference = []
        user_ambient = []
        user_ambient_preference_query.each do |q|
            user_ambient << q.ambient_id
            user_ambient_preference << q.id
		end
        
	user_ambient_preference_copy = user_ambient_preference.clone
	    
        user_id = user_logged.id
        
        if ambients != nil
            ambients.each do |a|
                a = a.to_i
                if not user_ambient.include?(a)
                    new_preference = AmbientPreference.new ({:ambient_id => a, :user_id => user_id})
                    new_preference.save
                else
                    index = user_ambient.index(a)
                    AmbientPreference.update(user_ambient_preference_copy[index], :is_active => true)
                    user_ambient_preference.delete_at(index)
                end
            end
        end
        
        user_ambient_preference.each do |u|
            AmbientPreference.update(u, :is_active => false)
        end
        
        redirect_to :action => 'register_preferences_food'
    end
    
    def register_preferences_food
        if user_is_authorized_?
            @title = "Preferencias Gastronômicas"
            
            foods = Food.all
            
            hash_foods = {}
            
            foods.each do |f|
                hash_foods[f.id] = f.name, FoodPreference.exists?(:user_id =>user_logged.id, :food_id => f.id, :is_active => true)
            end
            
            @checkboxes = hash_foods
            
            render layout: "pref"
        end
        
    end
    
    def register_preferences_food_create
        begin
            foods = params["food"]
        rescue
            foods = nil
        end
        
        user_food_preference_query = FoodPreference.where(:user_id => user_logged.id)
        
        user_food_preference = []
        user_food = []
        user_food_preference_query.each do |q|
            user_food << q.food_id
            user_food_preference << q.id
	end
	
	user_food_preference_copy = user_food_preference.clone
	    
	user_id = user_logged.id
        
        if foods != nil
            foods.each do |f|
                f = f.to_i
                if not user_food.include?(f)
                    new_preference = FoodPreference.new ({:food_id => f, :user_id => user_id})
                    new_preference.save
                else
                    index = user_food.index(f)
                    FoodPreference.update(user_food_preference_copy[index], :is_active => true)
                    user_food_preference.delete_at(index)
                end
            end
        end
        
        user_food_preference.each do |u|
            FoodPreference.update(u, :is_active => false)
        end
        
        redirect_to({:controller => 'dashboard', :action => 'preference_establishments_result'})
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
    		uploader = ImageUploader.new
            uploader.store!(values[:image])
    		new_establishment.save!
    		$establishment_id = new_establishment.id
            redirect_to :action => 'register_speciality_music'
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
    
    def register_speciality_music
        if user_is_authorized_?
            @title = "Especialidade: Música"
            musics = Music.all
            
            hash_musics = {}
            
            musics.each do |m|
                hash_musics[m.id] = m.name, MusicSpeciality.exists?(:establishment_id => $establishment_id,:music_id => m.id, :is_active => true)
            end
            
            @checkboxes = hash_musics
            
            render layout: "pref"
        end
    end
    
    def register_speciality_music_create
        begin
            musics = params["music"]
        rescue
            musics = nil
        end
        
        establishment_music_speciality_query = MusicSpeciality.where(:establishment_id => $establishment_id)
        
        establishment_music_speciality = []
        establishment_music = []
        establishment_music_speciality_query.each do |q|
            establishment_music << q.music_id
            establishment_music_speciality << q.id
		end
        
	establishment_music_speciality_copy = establishment_music_speciality.clone
	    
        establishment_id = $establishment_id
        
        if musics != nil
            musics.each do |m|
                m = m.to_i
                if not establishment_music.include?(m)
                    new_speciality = MusicSpeciality.new ({:music_id => m, :establishment_id => establishment_id})
                    new_speciality.save
                else
                    index = establishment_music.index(m)
                    MusicSpeciality.update(establishment_music_speciality_copy[index], :is_active => true)
                    establishment_music_speciality.delete_at(index)
                end
            end
        end
        
        establishment_music_speciality.each do |u|
            MusicSpeciality.update(u, :is_active => false)
        end
        
         redirect_to :action => 'register_speciality_ambient'
    end
    
    def register_speciality_ambient
        if user_is_authorized_?
            @title = "Especialidade: Ambiente"
            ambients = Ambient.all
            
            hash_ambients = {}
            
            ambients.each do |a|
                hash_ambients[a.id] = a.name, AmbientSpeciality.exists?(:establishment_id => $establishment_id,:ambient_id => a.id, :is_active => true)
            end
            
            @checkboxes = hash_ambients
            
            render layout: "pref"
        end
    end
    
    def register_speciality_ambient_create
        begin
            ambients = params["ambient"]
        rescue
            ambients = nil
        end
        
        establishment_ambient_speciality_query = AmbientSpeciality.where(:establishment_id => $establishment_id)
        
        establishment_ambient_speciality = []
        establishment_ambient = []
        establishment_ambient_speciality_query.each do |q|
            establishment_ambient << q.ambient_id
            establishment_ambient_speciality << q.id
		end
        
	establishment_ambient_speciality_copy = establishment_ambient_speciality.clone
	    
        establishment_id = $establishment_id
        if ambients != nil
            ambients.each do |a|
                a = a.to_i
                if not establishment_ambient.include?(a)
                    new_speciality = AmbientSpeciality.new ({:ambient_id => a, :establishment_id => establishment_id})
                    new_speciality.save
                else
                    index = establishment_ambient.index(a)
                    AmbientSpeciality.update(establishment_ambient_speciality_copy[index], :is_active => true)
                    establishment_ambient_speciality.delete_at(index)
                end
            end
        end
        
        establishment_ambient_speciality.each do |u|
            AmbientSpeciality.update(u, :is_active => false)
        end
        
        redirect_to :action => 'register_speciality_food'
    end
    
    
        
    def register_speciality_food
        if user_is_authorized_?
            @title = "Especialidade: Ambiente"
            foods = Food.all
            
            hash_foods = {}
            
            foods.each do |f|
                hash_foods[f.id] = f.name, FoodSpeciality.exists?(:establishment_id => $establishment_id,:food_id => f.id, :is_active => true)
            end
            
            @checkboxes = hash_foods
            
            render layout: "pref"
        end
    end
    
    def register_speciality_food_create
        begin
            foods = params["food"]
        rescue
            foods = nil
        end
        establishment_id = $establishment_id
        
        establishment_food_speciality_query = FoodSpeciality.where(:establishment_id => $establishment_id)
        
        establishment_food_speciality = []
        establishment_food = []
        establishment_food_speciality_query.each do |q|
            establishment_food << q.food_id
            establishment_food_speciality << q.id
        end
	    
	establishment_food_speciality_copy = establishment_food_speciality.clone
        
        if foods != nil
            foods.each do |f|
                f = f.to_i
                if not establishment_food.include?(f)
                    new_speciality = FoodSpeciality.new ({:food_id => f, :establishment_id => establishment_id})
                    new_speciality.save
                else
                    index = establishment_food.index(f)
                    FoodSpeciality.update(establishment_food_speciality_copy[index], :is_active => true)
                    establishment_food_speciality.delete_at(index)
                end
            end
        end
        
        establishment_food_speciality.each do |u|
            FoodSpeciality.update(u, :is_active => false)
        end
        
        redirect_to({:controller => 'dashboard', :action => 'preference_establishments_result'})
    end
    
    
    def add_provider_permission
        user_id = session[:current_user_id]
        User.update(user_id, :is_provider => true)
        redirect_to({:controller => 'dashboard', :action => 'my_establishments'})
    end
    
end

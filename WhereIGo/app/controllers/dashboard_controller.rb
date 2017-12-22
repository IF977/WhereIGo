class DashboardController < ApplicationController
    
    helper_method :user_logged
    helper_method :user_is_authorized_?
    helper_method :user_is_host_?
    
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
    
    def user_is_authorized_?(provider_autorization=false)
        if user_logged() == nil
            redirect_to({:controller =>'account', :action => 'login'}, :flash => {:error => "Faça login para continuar!"})  and return false
        else
            if provider_autorization
                user = user_logged()
                if user.is_provider != true
                    redirect_to({:controller =>'dashboard', :action => 'all_establishments'}, :flash => {:error => "É Necessária permissão de provedor para acessar essa função!"}) and return false
                end
            end
            return true
        end
    end
    
    def user_is_host_?
        user = user_logged()
        establishment = Establishment.find_by(id: params[:id])
        if establishment.user_id == user.id
            return true
        end
        return false
    end

    def preference_establishments_result
        @title = "Bares e restaurantes baseados no que você mais gosta"
        
        music_preference = MusicPreference.where(user_id: user_logged.id, is_active: true)
        food_preference = FoodPreference.where(user_id: user_logged.id, is_active: true)
        ambient_preference = AmbientPreference.where(user_id: user_logged.id, is_active: true)
        
        if music_preference == [] and food_preference == [] and ambient_preference == []
            @preferences_set = false
            return
        end
        
        @preferences_set = true
        
        music_specialyt_match = []
        food_specialyt_match = []
        ambient_specialyt_match =[]
        
        if music_preference != nil
            music_preference.each do |m|
                music_specialyt_match += MusicSpeciality.where(music_id: m.music_id, is_active: true)
            end
        end
        
        if food_preference != nil
            food_preference.each do |f|
                food_specialyt_match += FoodSpeciality.where(food_id: f.food_id, is_active: true)
            end
        end
        
        if ambient_preference != nil
            ambient_preference.each do |a|
                ambient_specialyt_match += AmbientSpeciality.where(ambient_id: a.ambient_id, is_active: true)
            end
        end
        
        all_matchs = music_specialyt_match + food_specialyt_match + ambient_specialyt_match
        
        establishments = []
        
        all_matchs.each do |e|
            establishment = Establishment.find_by(id: e.establishment_id, is_active: true)
            if not establishments.include?(establishment)
                if establishment != nil
                    establishments << establishment
                end
            end
        end
        
        @establishments = establishments
        
    end
    
    def search_establishments
        @filter = params[:filter]
        @title = "Resultado de pesquisa para " + @filter
        e = Establishment.arel_table
        @establishments = Establishment.where(e[:name].matches("%#{@filter}%")).where(:is_active => true)
        if user_is_authorized_?
            render layout: "dashboard"
        end
    end
    
    
    def all_establishments
        @title = "Dashboard"
        @establishments = Establishment.where(:is_active => true)
        
        if user_is_authorized_?
            render layout: "dashboard"
        end
    end
    
    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        
        establishment_food_speciality = FoodSpeciality.where(:establishment_id => @e.id, :is_active => true)
        establishment_music_speciality = MusicSpeciality.where(:establishment_id => @e.id, :is_active => true)
        establishment_ambient_speciality = AmbientSpeciality.where(:establishment_id => @e.id, :is_active => true)
        
        @food_tag = []
        @music_tag = []
        @ambient_tag = []
        
        if establishment_food_speciality != nil
            establishment_food_speciality.each do |f|
                food = Food.find_by(id: f.food_id)
                @food_tag << food.name
            end
        end
        
        if establishment_music_speciality != nil
            establishment_music_speciality.each do |m|
                music = Music.find_by(id: m.music_id)
                @music_tag << music.name
            end
        end
        
        if establishment_ambient_speciality != nil
            establishment_ambient_speciality.each do |a|
                ambient = Ambient.find_by(id: a.ambient_id)
                @ambient_tag << ambient.name
            end
        end
        
        user_review = EstablishmentReview.where(:user_id => session[:current_user_id]).where(:establishment_id => @e.id).first
        if user_review != nil
            @user_review_selected = user_review.review
        else
            @user_review_selected = nil
        end
        
        count_review_up = EstablishmentReview.where(:review => true).where(:establishment_id => @e.id).count
        count_review_down = EstablishmentReview.where(:review => false).where(:establishment_id => @e.id).count
        
        @count_reviews = count_review_up + count_review_down
        
        if count_review_up != 0 || count_review_down != 0
            rating = (count_review_up.to_f / (count_review_up + count_review_down)) * 100
            @rating_percentage = rating.round(0).to_s + '%'
        end
        
        @comments = []
        
        all_comments = EstablishmentComment.where(:establishment_id => @e.id, :is_active => true)
        all_comments.each do |c|
            user = User.find_by(id: c.user_id)
            user_name = user.name
            user_image = user.image
            comment_text = c.comment
            comment_date = c.created_at
            @comments << [user_name, user_image, comment_text, comment_date]
        end
        
        if user_is_authorized_?
            render layout: "dashboard"
        end
        
    end
    
    
    def user_comment_establishment
        user = session[:current_user_id]
        establishment = params[:id]
        comment_text = params[:establishment_comment][:comment]
        values = {:user_id => user,
                  :establishment_id => establishment,
                  :comment => comment_text
        }
        
        comment =  EstablishmentComment.new values
        if comment.valid?
            comment.save!
            redirect_to '/establishment/' + establishment
            return
        else
            if comment_text.strip == ""
                flash_message("O campo comentário está vazio.")
            end
        end
        
    end
    
    
    def user_review_establishment
        
        user = session[:current_user_id]
        establishment = params[:id]
        review = params[:review]
        values = {:user_id => user,
                  :establishment_id => establishment,
                  :review => review
        }
        
        #Checa se o user ja avaliou determinado restaurante
        user_reviews = EstablishmentReview.where(user_id: user)
        if user_reviews.exists?(:establishment_id => establishment)
            user_reviews.where(establishment_id: establishment).update(:review => review)
        else
            EstablishmentReview.create values
        end
        
        redirect_to '/establishment/' + establishment
        return
    
    end
    
    def new_establishment
        @title = "Novo estabelecimento"
        if user_is_authorized_?(true)
            render layout: "dashboard"
        end
    end
    
    def create_establishment
        values = params.require(:establishment).permit!
        new_establishment = Establishment.new values
        if new_establishment.valid?
            uploader = ImageUploader.new
            uploader.store!(values[:image])
    		new_establishment.update_attributes(:user_id => session[:current_user_id])
    		new_establishment.save!
             redirect_to :action => 'my_establishments'
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
    
    def my_establishments
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id], is_active: true)
        if user_is_authorized_?(true)
            render layout: "dashboard"
        end
    end
    
    def edit_my_establishment
        
        @establishments = Establishment.find_by(id: params[:id])
        $establishment_id = @establishments.id
        
        $establishment_id = @establishments.id
        
        if user_is_authorized_?(true) and user_is_host_?
            render layout: "dashboard"
            return
        else
            redirect_to({:controller =>'dashboard', :action => 'all_establishments'}, :flash => {:error => "É preciso ser dono do estabelecimento para fazer modificações!"}) and return
        end
        
        
    end
    
    def update_my_establishment
        
        values = params.require(:establishment).permit!
        
        update_establishment = Establishment.new values
        if not update_establishment.valid?
            if params[:establishment][:name].strip == ""
                flash_message("O campo nome é obrigatório.")
    		    return
    		
    		elsif params[:establishment][:address].strip == ""
    		    flash_message("O campo endereço é obrigatório.")
    		    return
    	    end
        else
            Establishment.update(params[:id], values)
            uploader = ImageUploader.new
            uploader.store!(values[:image])
            flash_message("Estabelecimento editado com sucesso.")
        end
    end
    
    def remove_my_establishment
        if user_is_host_?
            Establishment.update(params[:id], :is_active => false)
            redirect_to :action => 'my_establishments'
            return
        end
        redirect_to :action => 'all_establishments'
        return
    end
    
end

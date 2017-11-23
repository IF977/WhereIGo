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
                    redirect_to({:controller =>'dashboard', :action => 'all_establishments'}, :flash => {:error => "É Necessário perfil de provedor para acessar essa função!"}) and return false
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
    
    
    def all_establishments
        @title = "Dashboard"
        @establishments = Establishment.all
        
        if user_is_authorized_?
            render layout: "dashboard"
        end
    end
    
    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        
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
        
        all_comments = EstablishmentComment.where(:establishment_id => @e.id)
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
    		new_establishment.update_attributes(:user_id => session[:current_user_id])
    		new_establishment.save!
             redirect_to :action => 'my_establishments'
            return
        else
            if params[:establishment][:name].strip == ""
                flash_message("O campo nome é obrigatório.")
    		    return
    		elsif params[:establishment][:cnpj].size != 14
    		    flash_message("CNPJ inválido.")
                return
    		elsif params[:establishment][:address].strip == ""
    		    flash_message("O campo endereço é obrigatório.")
    		    return
    	    end
        end
    end
    
    def my_establishments
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
        if user_is_authorized_?(true)
            render layout: "dashboard"
        end
    end
    
    def edit_my_establishment
        
        @establishments = Establishment.find_by(id: params[:id])
        
        if user_is_authorized_?(true)
            render layout: "dashboard"
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
    
    
    
end

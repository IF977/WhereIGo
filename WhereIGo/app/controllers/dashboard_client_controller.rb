class DashboardClientController < ApplicationController
    
    def index
        @title = "Dashboard"
        @establishments = Establishment.all
        render layout: "client"
    end
    
    def show_establishment
        @e = Establishment.find_by(id: params[:id])
        @title = @e.name
        @count_review_up = EstablishmentReview.where(:review => true).where(:establishment_id => @e.id).count
        @count_review_down = EstablishmentReview.where(:review => false).where(:establishment_id => @e.id).count
        render layout: "client"
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
            new_review = EstablishmentReview.create values
        end
        
        redirect_to '/c/establishment/' + establishment
        return
    
    end
end

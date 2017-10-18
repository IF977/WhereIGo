class DashboardController < ApplicationController
    def index
        @title = "Dashboard"
        user = User.find_by(id: session[:current_user_id])
        @username = user.name
    end
    
    def user_review
        review = params[:review]
        user = session[:current_user_id]
        values = {:user_id => user,
                  :cnpj => "abcde",
                  :review => review
        }
        
        new_review = EstablishmentReview.create values
        new_review.review = review
        
        redirect_to '/establishments'
        return
    
        #user_reviews = EstablishmentReview.find(user_id: user)
        #if user_reviews.exists?(:cnpj => Establishment)
        #end
    end
    
end

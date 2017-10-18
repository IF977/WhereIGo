class EstablishmentController < ApplicationController
    def index
        @title = "Meus estabelecimentos"
        @establishments = Establishment.where(user_id: session[:current_user_id])
    end
    
    def new
        @title = "Novo estabelecimento"
    end
    
    def create
        values = params.require(:establishment).permit!
        if Establishment.exists?(:cnpj => params[:establishment][:cnpj])
            redirect_to '/establishments/new', :flash => { :error => "O CNPJ já está em uso." }
            return
        else
            new_establishment = Establishment.create values
            Establishment.update(new_establishment[:id], :user_id => session[:current_user_id])
            redirect_to '/establishments'
            return
        end
    end
    
    def show
        @establishments = Establishment.find_by(id: params[:id])
    end
    
    def update
        values = params.require(:establishment).permit!
        Establishment.update(params[:id], values)
        redirect_to '/establishments'
    end
    
    #private
    #def establishment_params
    #    params.require(:establishment).permit(:cnpj, :name, :address, :email, :website)
    #end
    
    def user_review
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
        
        redirect_to '/establishments'
        return
    
    end

end

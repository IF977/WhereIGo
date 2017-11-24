require 'rails_helper'

RSpec.describe EstablishmentReview, type: :model do
  
    before do
        values = {:name => 'edu',
                  :email => 'edu@edu',
                  :password_digest => 'eduedu',
        }
        valuesE = {:name => 'edu do espetinho',
                  :address => 'rua do espeto',
                  :email => 'edu@espeto',
                  :website => 'edu.edu'
        }
        @establishment = Establishment.create valuesE      
        @user = User.create values
    end

  context "avaliacao com joinha" do
    it "avalicao positiva - logado" do
        r = EstablishmentReview.new
        r.user_id = @user.id
        r.establishment_id = @establishment.id
        r.review = true
        expect(r.valid?).to be_truthy
    end
    
    it "avalicao negativa - logado" do
        r = EstablishmentReview.new
        r.user_id = @user.id
        r.establishment_id = @establishment.id
        r.review = false
        expect(r.valid?).to be_truthy
    end
    
    it "avalicao deslogado - caminho triste" do
        r = EstablishmentReview.new
        r.user_id = nil
        r.establishment_id = @establishment.id
        r.review = true
        expect(r.valid?).to be_falsey
    end
    
    end
end

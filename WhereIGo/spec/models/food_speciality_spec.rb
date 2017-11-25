require 'rails_helper'

RSpec.describe FoodSpeciality, type: :model do
       before do
        values = {:name => 'edu do espetinho',
                  :description => 'O MAIOR ESPETINHO EM LINHA RETA',
                  :address => 'rua do espeto',
                  :email => 'edu@espeto',
                  :website => 'edu.edu',
                  :user_id => 1
        }
        @establishment = Establishment.create values
        valuesFood = {:name => 'pizza'
        }
        @food = Food.create valuesFood
    end
    context "especialidade comida" do
        it "especialidade valida - establishment id e food id" do
            foodSpecialities = FoodSpeciality.new(establishment_id: @establishment.id, food_id: @food.id)
            expect(foodSpecialities.valid?).to be_truthy
        end
        it "preferencia invalida - sem establishment id" do
            foodSpecialities = FoodSpeciality.new(establishment_id: nil, food_id: @food.id)
            expect(foodSpecialities.valid?).to be_falsey
        end
        it "preferencia invalida - sem food id" do
            foodSpecialities = FoodSpeciality.new(establishment_id: @establishment.id, food_id: nil)
            expect(foodSpecialities.valid?).to be_falsey
        end
    end
end

require 'rails_helper'

RSpec.describe FoodPreference, type: :model do
before do
        values = {:name => 'edu',
                  :email => 'edu@edu',
                  :password_digest => 'eduedu'
        }
        @user = User.create values
        valuesFood = {:name => 'pizza'
        }
        @food = Food.create valuesFood
    end
    context "preferencia comida" do
        it "preferencia valida - user id e food id" do
            foodPreferences = FoodPreference.new(user_id: @user.id, food_id: @food.id)
            expect(foodPreferences.valid?).to be_truthy
        end
        it "preferencia invalida - sem user id" do
            foodPreferences = FoodPreference.new(user_id: nil, food_id: @food.id)
            expect(foodPreferences.valid?).to be_falsey
        end
        it "preferencia invalida - sem food id" do
            foodPreferences = FoodPreference.new(user_id: @user.id, food_id: nil)
            expect(foodPreferences.valid?).to be_falsey
        end
    end
end

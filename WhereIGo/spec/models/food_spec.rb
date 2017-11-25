require 'rails_helper'

RSpec.describe Food, type: :model do
    context "validade de uma comida" do 
        it "comida valida" do
          food = Food.new
          food.name = "fast food"
          expect(food.valid?).to be_truthy
        end
        
        it "comida invalida - campo nome vazio" do
          food = Food.new
          food.name = nil
          expect(food.valid?).to be_falsey
        end
    end
end

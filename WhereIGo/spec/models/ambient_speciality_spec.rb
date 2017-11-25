require 'rails_helper'

RSpec.describe AmbientSpeciality, type: :model do
      before do
        values = {:name => 'edu do espetinho',
                  :description => 'O MAIOR ESPETINHO EM LINHA RETA',
                  :address => 'rua do espeto',
                  :email => 'edu@espeto',
                  :website => 'edu.edu',
                  :user_id => 1
        }
        @establishment = Establishment.create values
        valuesAmbient = {:name => 'familiar'
        }
        @ambient = Ambient.create valuesAmbient
    end
    context "especialidade ambiente" do
        it "especialidade valida - establishment id e ambient id" do
            ambientSpecialities = AmbientSpeciality.new(establishment_id: @establishment.id, ambient_id: @ambient.id)
            expect(ambientSpecialities.valid?).to be_truthy
        end
        it "especialidade invalida - sem establishment id" do
            ambientSpecialities = AmbientSpeciality.new(establishment_id: nil, ambient_id: @ambient.id)
            expect(ambientSpecialities.valid?).to be_falsey
        end
        it "especialidade invalida - sem ambient id" do
            ambientSpecialities = AmbientSpeciality.new(establishment_id: @establishment_id, ambient_id: nil)
            expect(ambientSpecialities.valid?).to be_falsey
        end
    end    
end

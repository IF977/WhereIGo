require 'rails_helper'

RSpec.describe AmbientPreference, type: :model do
  
    before do
        values = {:name => 'edu',
                  :email => 'edu@edu',
                  :password_digest => 'eduedu'
        }
        @user = User.create values
        valuesAmbient = {:name => 'familiar'
        }
        @ambient = Ambient.create valuesAmbient
    end
    context "preferencia ambiente" do
        it "preferencia valida - user id e ambient id" do
            ambientPreferences = AmbientPreference.new(user_id: @user.id, ambient_id: @ambient.id)
            expect(ambientPreferences.valid?).to be_truthy
        end
        it "preferencia invalida - sem user id" do
            ambientPreferences = AmbientPreference.new(user_id: nil, ambient_id: @ambient.id)
            expect(ambientPreferences.valid?).to be_falsey
        end
        it "preferencia valida - sem ambient id" do
            ambientPreferences = AmbientPreference.new(user_id: @user.id, ambient_id: nil)
            expect(ambientPreferences.valid?).to be_falsey
        end
    end
end

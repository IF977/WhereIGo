require 'rails_helper'

RSpec.describe MusicSpeciality, type: :model do
       before do
        values = {:name => 'edu do espetinho',
                  :description => 'O MAIOR ESPETINHO EM LINHA RETA',
                  :address => 'rua do espeto',
                  :email => 'edu@espeto',
                  :website => 'edu.edu',
                  :user_id => 1
        }
        @establishment = Establishment.create values
        valuesMusic = {:name => 'rock'
        }
        @music = Music.create valuesMusic
    end

    context "especialidade musica" do
        it "especialidade valida - establishment id e musica id" do
            musicSpecialities = MusicSpeciality.new(establishment_id: @establishment.id, music_id: @music.id)
            expect(musicSpecialities.valid?).to be_truthy
        end
        it "especialidade invalida - sem establishment id" do
            musicSpecialities = MusicSpeciality.new(establishment_id: nil, music_id: @music.id)
            expect(musicSpecialities.valid?).to be_falsey
        end
        it "especialidade invalida - sem music id" do
            musicSpecialities = MusicSpeciality.new(establishment_id: @establishment.id, music_id: nil)
            expect(musicSpecialities.valid?).to be_falsey
        end
    end    
    
end

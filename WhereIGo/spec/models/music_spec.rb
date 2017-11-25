require 'rails_helper'

RSpec.describe Music, type: :model do
    context "validade de uma musica" do 
        it "musica valida" do
          music = Music.new
          music.name = "brega"
          expect(music.valid?).to be_truthy
        end
        
        it "musica invalida - campo musica vazio" do
          music = Music.new
          music.name = nil
          expect(music.valid?).to be_falsey
        end
    end
end

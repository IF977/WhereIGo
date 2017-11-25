require 'rails_helper'

RSpec.describe MusicPreference, type: :model do
before do
        values = {:name => 'edu',
                  :email => 'edu@edu',
                  :password_digest => 'eduedu'
        }
        @user = User.create values
        valuesMusic = {:name => 'rock'
        }
        @music = Music.create valuesMusic
    end
    context "preferencia musica" do
        it "preferencia valida - user id e musica id" do
            musicPreferences = MusicPreference.new(user_id: @user.id, music_id: @music.id)
            expect(musicPreferences.valid?).to be_truthy
        end
        it "preferencia invalida - sem user id" do
            musicPreferences = MusicPreference.new(user_id: nil, music_id: @music.id)
            expect(musicPreferences.valid?).to be_falsey
        end
        it "preferencia invalida - sem music id" do
            musicPreferences = MusicPreference.new(user_id: @user.id, music_id: nil)
            expect(musicPreferences.valid?).to be_falsey
        end
    end
end

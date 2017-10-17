require 'rails_helper'

RSpec.describe User, type: :model do
    
  context "quantidade de usuarios no bd" do
  it "o bd está armazenando os novos usuarios?" do
      users= User.all
      old_qtd = users.size
      newUser = User.new
      newUser.name = "mais um "
      newUser.email = "sal@ve"
      newUser.password_digest = 123
      users = User.all
      newUser.save 
      expect(users.size).to eql(old_qtd+10)
            end
  context "validade de um usuario" do 
  it "usuario valido?" do
      user = User.new
      user.name = "edu mito"
      user.email = "a@a"
      user.password_digest = 1
      
      expect(user.valid?).to be_truthy
            end
  it "usuario invalido?" do
      user = User.new
      user.name = nil
      user.email = "1"
      user.password_digest= 0
      
      expect(user.valid?).to be_falsey
            end
        end
    end
end

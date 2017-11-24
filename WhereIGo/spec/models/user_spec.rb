require 'rails_helper'

RSpec.describe User, type: :model do

  before do
      values = {:name => 'edu',
                :email => 'edu@edu',
                :password_digest => 'edueduedu'}
      @userTest = User.create values
    end


  context "testando a edição de usuario" do
    it "o usuario tentar editar a conta passando a senha certa" do
        visit '/login'
        fill_in "email", :with => @userTest.email
        fill_in "password", :with =>@userTest.password_digest
        click_button "Entrar"
        visit '/dashboard/account'
        fill_in "user_name", :with => "Pedro"
        fill_in 'user_email', :with => @userTest.email
        fill_in 'user_password_digest', :with => 'edueduedu'
        click_button 'Salvar'
        expect(page).to have_text 'Conta editada com sucesso!'
    end
    
    it "o usuario tentar editar a conta passando a senha errada" do
        visit '/login'
        fill_in "email", :with => @userTest.email
        fill_in "password", :with =>@userTest.password_digest
        click_button "Entrar"
        visit '/dashboard/account'
        fill_in "user_name", :with => "Pedro"
        fill_in 'user_email', :with => @userTest.email
        fill_in 'user_password_digest', :with => 'senhaerrada'
        click_button 'Salvar'
        expect(page).to have_content 'Senha incorreta.'
    end
  end  
  context "quantidade de usuarios no banco de dados" do
    it "o banco de dados está armazenando os novos usuarios?" do
      users= User.count
      old_qtd = users
      newUser = User.new
      newUser.name = "mais um"
      newUser.email = "sal@ve"
      newUser.password_digest = 123456
      newUser.save 
      newUsersCount = User.count
      expect(newUsersCount).to eql(old_qtd+1)
        end
    end
  context "validade de um usuario" do 
    it "usuario valido" do
      user = User.new
      user.name = "edu mito"
      user.email = "a@a"
      user.password_digest = 123456
      
      expect(user.valid?).to be_truthy
            end
    it "usuario invalido - campo nome vazio" do
      user = User.new
      user.name = nil
      user.email = "abc@df"
      user.password_digest= 0
      
      expect(user.valid?).to be_falsey
        end
        
    it "usuario invalido - campo email vazio" do
      user = User.new
      user.name = "Sheldon Diamante Negro"
      user.email = ""
      user.password_digest= "sheldondiamente123"
      
      expect(user.valid?).to be_falsey
        end
        
    it "usuario invalido - campo senha com menos de 6 (seis) dígitos" do
      user = User.new
      user.name = "DJ Val"
      user.email = "detona@djval"
      user.password_digest= "1357"
      
      expect(user.valid?).to be_falsey
        end
    end
end

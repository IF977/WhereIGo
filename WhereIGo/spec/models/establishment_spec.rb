require 'rails_helper'

RSpec.describe Establishment, type: :model do
  
before do
  valuesUser = {:name => 'edu',
            :email => 'edu@edu',
            :password_digest => 'edueduedu'}
  @userTest = User.create valuesUser
  
  valuesEstablishment = {:name => 'rio doce cdu',
  :email => 'rio@doce',
  :cnpj => '12345678901230',
  :address => 'terminal mais proximo',
  :website => nil}
  
  @establishmentTest = Establishment.create valuesEstablishment
end
=begin
context "testes de edição de estabelecimento" do
    it "edição de estabelecimento - como gerente" do
      visit '/login'
      fill_in "email", :with => @userTest.email
      fill_in "password", :with =>@userTest.password_digest
      click_button "Entrar"
      visit '/dashboard'
      expect(page).to have_content 'Editar conta'
      
      visit '/establishments/new'
      fill_in "establishment_name", :with => @establishmentTest.name
      fill_in 'establishment_email', :with => @establishmentTest.email
      fill_in 'establishment_cnpj', :with => '82345678901230'
      fill_in 'establishment_address', :with => @establishmentTest.address
      click_button 'Criar estabelecimento'
      visit '/establishments'
      expect(page).to have_content '1.'
      #click_button 'rio doce cdu'
      #page.find(:link,"rio doce cdu").click
      #click_link '/establishments/1'
      #expect(page).to have_text 'Salvar alterações'
  end
end
=end
context "quantidade de estabelecimentos no banco de dados" do
    it "o banco de dados está armazenando os novos estabelecimentos?" do
      establishment= Establishment.count
      old_qtd = establishment
      newEstablishment = Establishment.new
      newEstablishment.name = "mais um bar"
      newEstablishment.email = "sal@ve"
      newEstablishment.cnpj = 12345678901234
      newEstablishment.address = "Rua do Toanha"
      newEstablishment.save 
      newEstablishmentCount = Establishment.count
      expect(newEstablishmentCount).to eql(old_qtd+1)
        end
    end
  context "validade de um estabelecimento" do 
    it "estabelecimento valido?" do
      establishment = Establishment.new
      establishment.name = "bar do cava"
      establishment.email = "bar@cava"
      establishment.cnpj = 12345678901233
      establishment.address = "Próximo a UFPE"
      establishment.website = "cava.com.br"
      
      expect(establishment.valid?).to be_truthy
            end
    it "estabelecimento valido? - campo website vazio" do
      establishment = Establishment.new
      establishment.name = "bar da kelly"
      establishment.email = "bar@kelly"
      establishment.cnpj = 12345678901230
      establishment.address = "Próximo a UFPE"
      establishment.website = ""
      
      expect(establishment.valid?).to be_truthy
            end        
    it "estabelecimento valido? - nome vazio" do
      establishment = Establishment.new
      establishment.name = ""
      establishment.email = "bar@semnome"
      establishment.cnpj = 12345678901231
      establishment.address = "Próximo a UFPE"
      establishment.website = "semnome.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
        
    it "estabelecimento valido? - campo email vazio" do
      establishment = Establishment.new
      establishment.name = "bar sem email"
      establishment.email = ""
      establishment.cnpj = 12345678901232
      establishment.address = "Próximo a UFPE"
      establishment.website = "sememail.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    it "estabelecimento valido? - campo CNPJ com menos de 14 digitos" do
      establishment = Establishment.new
      establishment.name = "bar do CNPJ errado"
      establishment.email = "bar@cnpj"
      establishment.cnpj = 123
      establishment.address = "Próximo a UFPE"
      establishment.website = "cnpjerrado.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    it "estabelecimento valido? - campo CNPJ com mais de 14 digitos" do
      establishment = Establishment.new
      establishment.name = "bar cpnj 2"
      establishment.email = "bar2@cnpj"
      establishment.cnpj = 123123123123123123123123123
      establishment.address = "Próximo a UFPE"
      establishment.website = "bar2cpnj.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    it "estabelecimento valido? - campo endereço vazio" do
      establishment = Establishment.new
      establishment.name = "bar sem endereço"
      establishment.email = "sem@endereco"
      establishment.cnpj = 12345678901238
      establishment.address = ""
      establishment.website = "semendereco.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    end
end
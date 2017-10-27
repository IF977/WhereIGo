require 'rails_helper'

RSpec.describe Establishment, type: :model do
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
    it "estabelecimento valido? - caminho feliz" do
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
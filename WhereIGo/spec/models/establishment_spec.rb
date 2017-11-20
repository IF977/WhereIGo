require 'rails_helper'

RSpec.describe Establishment, type: :model do
  
      before do
        values = {:name => 'edu do espetinho',
                  :cnpj => '12345678901234',
                  :description => 'O MAIOR ESPETINHO EM LINHA RETA',
                  :address => 'rua do espeto',
                  :email => 'edu@espeto',
                  :website => 'edu.edu',
                  :user_id => 1
        }
        @establishment = Establishment.create values
    end
  
  context "edicao de dados do estabelecimento" do
    it "edicao de nome - valida" do
      @establishment.name = "kea"
      expect(@establishment.name).to eq("kea")
      expect(@establishment.valid?).to be_truthy
    end
    
    it "edicao de nome para vazio - invalida" do
      @establishment.name = nil
      expect(@establishment.valid?).to be_falsey
    end
    
    it "edicao de cnpj - valida" do
      @establishment.cnpj = '12345678900000'
      expect(@establishment.cnpj).to eq('12345678900000')
      expect(@establishment.valid?).to be_truthy
    end
    
    it "edicao de cnpj - invalida - mais de 14 caracteres" do
      @establishment.cnpj = '123456789000001'
      expect(@establishment.valid?).to be_falsey
    end    

    it "edicao de cnpj - invalida - campo vazio" do
      @establishment.cnpj = nil
      expect(@establishment.valid?).to be_falsey
    end    

    it "edicao de descricao- valida" do
      @establishment.description= 'O maior e melhor de Recife'
      expect(@establishment.description).to eq('O maior e melhor de Recife')
      expect(@establishment.valid?).to be_truthy
    end
    
    it "edicao de endereco - valida" do
      @establishment.address = 'Rua do futuro'
      expect(@establishment.address).to eq('Rua do futuro')
      expect(@establishment.valid?).to be_truthy
    end        

    it "edicao de endereco para vazio - invalida" do
      @establishment.address = nil
      expect(@establishment.valid?).to be_falsey
    end        
 
    it "edicao de email - valida" do
      @establishment.email = 'espeto@edu'
      expect(@establishment.email).to eq('espeto@edu')
      expect(@establishment.valid?).to be_truthy
    end        

    it "edicao de email para vazio - valida" do
      @establishment.email = nil
      expect(@establishment.valid?).to be_truthy
    end    
        
    it "edicao de website - valida" do
      @establishment.website = 'espeto.edu.edu'
      expect(@establishment.website).to eq('espeto.edu.edu')
      expect(@establishment.valid?).to be_truthy
    end        

    it "edicao de website - valida - campo vazio" do
      @establishment.website = nil
      expect(@establishment.valid?).to be_truthy
    end   
    
    it "edicao de mais de um campo ao mesmo tempo" do
      @establishment.name = "kea"
      expect(@establishment.name).to eq("kea")      
      @establishment.cnpj = '12345678900000'
      expect(@establishment.cnpj).to eq('12345678900000')
      @establishment.description = 'A maior variedade de espetinho é aqui'
      expect(@establishment.description).to eq('A maior variedade de espetinho é aqui')      
      @establishment.address = 'Rua do futuro'
      expect(@establishment.address).to eq('Rua do futuro')
      @establishment.email = 'espeto@edu'
      expect(@establishment.email).to eq('espeto@edu')      
      @establishment.website = 'espeto.edu.edu'
      expect(@establishment.website).to eq('espeto.edu.edu')
      expect(@establishment.valid?).to be_truthy      
    end
  end
  context "quantidade de estabelecimentos no banco de dados" do
    it "o banco de dados está armazenando os novos estabelecimentos?" do
      establishment= Establishment.count
      old_qtd = establishment
      newEstablishment = Establishment.new
      newEstablishment.name = "mais um bar"
      newEstablishment.email = "sal@ve"
      newEstablishment.cnpj = 12345678901234
      newEstablishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
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
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = "cava.com.br"
      
      expect(establishment.valid?).to be_truthy
            end

    it "estabelecimento valido? - campo descricao vazio" do
      establishment = Establishment.new
      establishment.name = "bar da kelly"
      establishment.email = "bar@kelly"
      establishment.cnpj = 12345678901230
      establishment.description = ""
      establishment.address = "Próximo a UFPE"
      establishment.website = "semnome.com.br"
      
      expect(establishment.valid?).to be_truthy
            end                 
            
    it "estabelecimento valido? - campo website vazio" do
      establishment = Establishment.new
      establishment.name = "bar da kelly"
      establishment.email = "bar@kelly"
      establishment.cnpj = 12345678901230
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = ""
      
      expect(establishment.valid?).to be_truthy
            end        
    it "estabelecimento valido? - nome vazio" do
      establishment = Establishment.new
      establishment.name = ""
      establishment.email = "bar@semnome"
      establishment.cnpj = 12345678901231
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = "semnome.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
        
    it "estabelecimento valido? - campo email vazio" do
      establishment = Establishment.new
      establishment.name = "bar sem email"
      establishment.email = ""
      establishment.cnpj = 12345678901232
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = "sememail.com.br"
      
      expect(establishment.valid?).to be_truthy
            end
    it "estabelecimento valido? - campo CNPJ com menos de 14 digitos" do
      establishment = Establishment.new
      establishment.name = "bar do CNPJ errado"
      establishment.email = "bar@cnpj"
      establishment.cnpj = 123
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = "cnpjerrado.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    it "estabelecimento valido? - campo CNPJ com mais de 14 digitos" do
      establishment = Establishment.new
      establishment.name = "bar cpnj 2"
      establishment.email = "bar2@cnpj"
      establishment.cnpj = 123123123123123123123123123
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = "Próximo a UFPE"
      establishment.website = "bar2cpnj.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    it "estabelecimento valido? - campo endereço vazio" do
      establishment = Establishment.new
      establishment.name = "bar sem endereço"
      establishment.email = "sem@endereco"
      establishment.cnpj = 12345678901238
      establishment.description = "Quem gosta gosta, quem nao gosta nao conhece"
      establishment.address = ""
      establishment.website = "semendereco.com.br"
      
      expect(establishment.valid?).to be_falsey
            end
    end
end
require 'smarter_csv'

class ImportCsvController < ApplicationController
    
    $teste = "qweqwe"
    def show
        @title = $teste 
    end
    
    def check_food(name)
        if name != nil
            if Food.find_by(name: name) != nil
                true
            else
                false
            end
        else
            true
        end
    end
        
    def import
        values = params.require(:file).permit!
        @arquivo = values[:file1]
        
        SmarterCSV.process(@arquivo.path, col_sep: ';') do |row|
           e = Establishment.new
           f = Food.new
           fe = FoodSpeciality.new
           e.name = row[0][:nome]
           e.address = row[0][:endereco]
           e.email = row[0][:email]
           e.website = row[0][:site]
           e.phone = row[0][:telefone]
           e.save!
           if row[0][:especialidade] != nil
                f.name = row[0][:especialidade].downcase!
                if check_food(f.name) == false
                    f.save!
                end
           end
           fe.establishment_id = e.id
           food = Food.find_by(name: f.name)
           if food != nil
                fe.food_id = food.id
                fe.save!
           end
           
        end
        
    
end
end

require 'smarter_csv'
class BackOfficeController < ApplicationController
    
    def user_authorized_?
        if session[:current_user_id] != nil
            user = User.find_by(id: session[:current_user_id])
            if user.email == "backoffice@wig"
                return true
            end
        end
        redirect_to({:controller => 'dashboard', :action => 'all_establishments'}) and return false
    end
    
    def import_all_data
        if user_authorized_?
            @title = "Migração de dados - BackOffice WhereIGo"
        end
    end
      
    def bootstrap_all_data
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
    
        values = params.require(:file).permit!
        arquivo_e = values[:file_establishments]
        arquivo_m = values[:file_musics]
        arquivo_a = values[:file_ambients]
        
        SmarterCSV.process(arquivo_e.path, col_sep: ';') do |row|
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
        
        SmarterCSV.process(arquivo_m.path, col_sep: ';') do |row|
            m = Music.new
            m.name = row[0][:genre]
            m.save!
        end
            
        SmarterCSV.process(arquivo_a.path, col_sep: ';') do |row|
            a = Ambient.new
            a.name = row[0][:ambient]
            a.save!
        end
    end
end

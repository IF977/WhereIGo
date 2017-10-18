class Establishment < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    validates :name, presence:true
    validates :email, presence:true
    validates :cnpj, presence:true
    validates :address, presence:true
end

class Establishment < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    validates :name, presence:true
    validates_length_of :cnpj, :minimum => 14, :maximum => 14
    validates :address, presence:true
end

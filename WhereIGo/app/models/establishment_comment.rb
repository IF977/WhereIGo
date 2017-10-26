class EstablishmentComment < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
     validates :comment, presence:true
end

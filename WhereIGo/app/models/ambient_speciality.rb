class AmbientSpeciality < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    validates :ambient_id, presence:true
    validates :establishment_id, presence:true
end

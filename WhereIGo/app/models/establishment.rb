class Establishment < ApplicationRecord
    belongs_to :user
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end

end

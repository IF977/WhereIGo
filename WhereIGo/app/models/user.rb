class User < ApplicationRecord
    #has_secure_password
    has_many :establishments
    after_initialize :set_default_values
    
    def set_default_values
        self.is_provider ||= false
        self.is_active ||= true
    end
  
end

class User < ApplicationRecord
    #has_secure_password
  
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    validates :name, format: { without: /\s/ }
    validates :name, presence:true
    validates :name, format: { with: /\A[a-zA-Z]+\Z/ }
end

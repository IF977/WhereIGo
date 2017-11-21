class User < ApplicationRecord
    has_secure_password
  
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    mount_uploader :image, ImageUploader

    validates :name, presence:true
    validates :email, presence:true
    validates_length_of :password_digest, :minimum => 6
end


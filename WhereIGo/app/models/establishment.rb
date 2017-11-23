class Establishment < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    mount_uploader :image, ImageUploader
    
    validates :name, presence:true
    validates :address, presence:true
end

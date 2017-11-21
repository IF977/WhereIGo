class Establishment < ApplicationRecord
    after_initialize :set_default_values
    
    def set_default_values
        self.is_active ||= true
    end
    
    mount_uploader :image, ImageUploader
    
    validates :name, presence:true
    validates :email, presence:true
    validates :address, presence:true
    validates_length_of :cnpj, :minimum => 14, :maximum => 14
end

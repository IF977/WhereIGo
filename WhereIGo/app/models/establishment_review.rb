class EstablishmentReview < ApplicationRecord
    validates :establishment_id, presence:true
    validates :user_id, presence:true
end

require 'rails_helper'

RSpec.describe User, type: :model do
  validates :name, presence:true
  validates :password_digest, presence:true
end

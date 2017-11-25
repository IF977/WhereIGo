require 'rails_helper'

RSpec.describe Ambient, type: :model do
    context "validade de um ambiente" do 
        it "ambiente valido" do
          ambient = Ambient.new
          ambient.name = "familiar"
          expect(ambient.valid?).to be_truthy
        end
        
        it "ambiente invalido - campo nome vazio" do
          ambient = Ambient.new
          ambient.name = nil
          expect(ambient.valid?).to be_falsey
        end
    end
end

require 'rails_helper'

RSpec.describe EstablishmentComment, type: :model do

  context "criacao de comentario" do
    it "criacao valida - possui texto" do
    comment = EstablishmentComment.new
    comment.comment = "Restaurante muito bom, recomendo"
    expect(comment.valid?).to be_truthy
        end
    it "criacao invalida - campo vazio" do
    comment = EstablishmentComment.new
    comment.comment = ""
    expect(comment.valid?).to be_falsey
        end
    end
end

class CreateEstablishmentReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :establishment_reviews do |t|
      t.string :user_id
      t.string :cnpj
      t.boolean :review
      t.timestamps
    end
  end
end

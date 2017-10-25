class CreateEstablishmentReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :establishment_reviews do |t|
      t.integer :user_id
      t.integer :establishment_id
      t.boolean :review

      t.timestamps
    end
  end
end

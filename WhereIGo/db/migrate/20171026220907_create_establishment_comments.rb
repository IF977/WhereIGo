class CreateEstablishmentComments < ActiveRecord::Migration[5.1]
  def change
    create_table :establishment_comments do |t|
      t.string :comment
      t.boolean :is_active
      t.integer :user_id
      t.integer :establishment_id

      t.timestamps
    end
  end
end

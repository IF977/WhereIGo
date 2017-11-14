class CreateAmbientPrefences < ActiveRecord::Migration[5.1]
  def change
    create_table :ambient_prefences do |t|
      t.integer :ambient_id
      t.integer :user_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

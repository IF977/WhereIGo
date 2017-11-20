class CreateAmbientPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :ambient_preferences do |t|
      t.integer :user_id
      t.integer :ambient_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

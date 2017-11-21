class CreateAmbientSpecialities < ActiveRecord::Migration[5.1]
  def change
    create_table :ambient_specialities do |t|
      t.integer :establishment_id
      t.integer :ambient_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

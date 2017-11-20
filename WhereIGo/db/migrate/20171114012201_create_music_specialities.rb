class CreateMusicSpecialities < ActiveRecord::Migration[5.1]
  def change
    create_table :music_specialities do |t|
      t.integer :establishment_id
      t.integer :music_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

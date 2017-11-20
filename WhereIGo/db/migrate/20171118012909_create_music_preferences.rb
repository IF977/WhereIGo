class CreateMusicPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :music_preferences do |t|
      t.integer :user_id
      t.integer :music_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

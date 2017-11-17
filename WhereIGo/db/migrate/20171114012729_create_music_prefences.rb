class CreateMusicPrefences < ActiveRecord::Migration[5.1]
  def change
    create_table :music_prefences do |t|
      t.integer :music_id
      t.integer :user_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

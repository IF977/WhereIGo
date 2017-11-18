class CreateFoodPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :food_preferences do |t|
      t.integer :user_id
      t.integer :food_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

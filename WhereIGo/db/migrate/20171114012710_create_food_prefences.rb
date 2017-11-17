class CreateFoodPrefences < ActiveRecord::Migration[5.1]
  def change
    create_table :food_prefences do |t|
      t.integer :food_id
      t.integer :user_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

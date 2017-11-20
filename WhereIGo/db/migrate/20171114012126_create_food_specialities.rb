class CreateFoodSpecialities < ActiveRecord::Migration[5.1]
  def change
    create_table :food_specialities do |t|
      t.integer :establishment_id
      t.integer :food_id
      t.boolean :is_active

      t.timestamps
    end
  end
end

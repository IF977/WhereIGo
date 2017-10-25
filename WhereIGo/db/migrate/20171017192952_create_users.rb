class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :is_client
      t.boolean :is_provider
      t.boolean :is_active
 
      t.timestamps
    end
  end
end

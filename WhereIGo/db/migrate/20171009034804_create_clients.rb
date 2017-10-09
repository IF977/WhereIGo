class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end

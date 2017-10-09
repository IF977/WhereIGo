class CreateEstablishments < ActiveRecord::Migration[5.1]
  def change
    create_table :establishments do |t|
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :email
      t.string :website
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end

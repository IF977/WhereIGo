class RemoveCnpjFromEstablishment < ActiveRecord::Migration[5.1]
  def change
    remove_column :establishments, :cnpj, :string
  end
end

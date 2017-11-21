class AddImageToEstablishment < ActiveRecord::Migration[5.1]
  def change
    add_column :establishments, :image, :string
  end
end

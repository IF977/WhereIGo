class AddDescriptionToEstablishment < ActiveRecord::Migration[5.1]
  def change
    add_column :establishments, :description, :text
  end
end

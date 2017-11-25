class AddPhoneToEstablishments < ActiveRecord::Migration[5.1]
  def change
    add_column :establishments, :phone, :string
  end
end

class RemoveIsClientFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_client, :boolean
  end
end

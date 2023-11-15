class RemoveAdminFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :admin
    remove_column :users, :admin
  end
end

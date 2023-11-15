class AddColumnAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_index :users, :admin
  end
end

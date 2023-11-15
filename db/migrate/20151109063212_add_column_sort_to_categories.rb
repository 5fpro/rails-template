class AddColumnSortToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :sort, :integer
    add_index :categories, :sort
  end
end

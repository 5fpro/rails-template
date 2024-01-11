class CreateCatalogs < ActiveRecord::Migration[7.1]
  def up
    create_table :catalogs do |t|
      t.string :layout
      t.string :name
      t.integer :parent_id
      t.boolean :enabled, default: false
      t.integer :sort
      t.integer :deep, default: 0, comment: '目前分層深度'
      t.integer :tree_position
      t.integer :items_count, default: 0, comment: '物件數'
      t.integer :context_id
      t.integer :creator_id
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :catalogs, :layout
    add_index :catalogs, [:layout, :enabled]
    add_index :catalogs, [:layout, :enabled, :parent_id]
    add_index :catalogs, [:layout, :enabled, :tree_position]
    add_index :catalogs, [:layout, :enabled, :sort]
    add_index :catalogs, [:layout, :deep, :sort]
    add_index :catalogs, [:layout, :enabled, :deep, :sort]
    add_index :catalogs, [:layout, :context_id]
    add_index :catalogs, [:layout, :creator_id]
    add_index :catalogs, :data, using: :gin
    add_index :catalogs, :name, using: :gin, opclass: :gin_trgm_ops

    create_table :catalog_items do |t|
      t.string :layout
      t.integer :catalog_id
      t.string :item_type
      t.integer :item_id
      t.integer :sort
      t.integer :context_id
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :catalog_items, :catalog_id
    add_index :catalog_items, [:item_id, :item_type]
    add_index :catalog_items, [:layout, :catalog_id]
    add_index :catalog_items, [:context_id, :catalog_id]
    add_index :catalog_items, [:context_id, :layout, :sort]
    add_index :catalog_items, [:item_id, :sort]
    add_index :catalog_items, [:item_id, :item_type, :sort]
    add_index :catalog_items, [:context_id, :item_id, :item_type]
    add_index :catalog_items, [:context_id, :item_id, :item_type, :catalog_id], name: 'index_catalog_items_on_context_id_and_item_and_and_catalog_id'
    add_index :catalog_items, :data, using: :gin
  end

  def down
    drop_table :catalogs
    drop_table :catalog_items
  end
end

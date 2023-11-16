class CreateMylists < ActiveRecord::Migration[6.0]
  def up
    create_table :mylists do |t|
      t.string :layout
      t.integer :context_id
      t.string :owner_type
      t.integer :owner_id
      t.string :item_type
      t.integer :item_id
      t.integer :sort
      t.string :item_label
      t.string :item_identity
      t.date :created_on
      t.jsonb :item_data, default: {}
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :mylists, [:layout]
    add_index :mylists, [:context_id]
    add_index :mylists, [:owner_id]
    add_index :mylists, [:owner_type, :owner_id]
    add_index :mylists, [:item_id]
    add_index :mylists, [:item_type, :item_id]
    add_index :mylists, [:owner_id, :item_id]
    add_index :mylists, [:layout, :owner_id, :item_id]
    add_index :mylists, [:owner_id, :item_identity]
    add_index :mylists, [:layout, :owner_id, :item_identity]
    add_index :mylists, [:created_on]
    add_index :mylists, [:context_id, :created_on]
    add_index :mylists, [:layout, :context_id, :created_on]
    add_index :mylists, :item_label, using: :gin, opclass: :gin_trgm_ops
    add_index :mylists, :item_data, using: :gin
    add_index :mylists, :data, using: :gin
  end

  def down
    drop_table :mylists
  end
end

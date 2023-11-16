class CreateOrders < ActiveRecord::Migration[6.0]
  def up
    create_table :orders do |t|
      t.string :layout
      t.string :sn
      t.string :user_type
      t.integer :user_id
      t.string :creator_type
      t.integer :creator_id
      t.string :currency
      t.decimal :total_amount
      t.integer :state
      t.integer :payment_state
      t.string :context_type
      t.integer :context_id
      t.text :for_text_search
      t.date :created_on
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :orders, [:context_type, :context_id, :sn]
    add_index :orders, [:sn]
    add_index :orders, [:layout, :sn]
    add_index :orders, [:user_type, :user_id]
    add_index :orders, [:user_type, :user_id, :layout]
    add_index :orders, [:user_type, :user_id, :context_id, :context_type], name: 'index_orders_on_user_and_context'
    add_index :orders, [:creator_type, :creator_id]
    add_index :orders, [:creator_type, :creator_id, :layout]
    add_index :orders, [:creator_type, :creator_id, :context_id, :context_type], name: 'index_orders_on_creator_and_context'
    add_index :orders, [:state]
    add_index :orders, [:state, :layout]
    add_index :orders, [:state, :context_id, :context_type]
    add_index :orders, [:payment_state]
    add_index :orders, [:payment_state, :layout]
    add_index :orders, [:payment_state, :context_id, :context_type]
    add_index :orders, [:created_on]
    add_index :orders, [:created_on, :layout]
    add_index :orders, [:created_on, :context_id, :context_type]
    add_index :orders, :data, using: :gin
    add_index :orders, [:data, :layout], using: :gin
    add_index :orders, [:data, :context_id, :context_type], using: :gin
    add_index :orders, :for_text_search, using: :gin, opclass: :gin_trgm_ops
  end

  def down
    drop_table :orders
  end
end

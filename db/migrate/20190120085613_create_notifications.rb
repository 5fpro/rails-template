class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :sender_type
      t.string :sender_id
      t.string :receiver_type
      t.string :receiver_id
      t.string :object_type
      t.string :object_id
      t.string :notify_type
      t.boolean :readed, default: false
      t.string :subject
      t.string :body
      t.date   :created_on
      t.jsonb  :data, default: {}
      t.timestamps
    end
    add_index :notifications, :notify_type
    add_index :notifications, [:sender_type, :sender_id]
    add_index :notifications, [:receiver_type, :receiver_id]
    add_index :notifications, [:object_type, :object_id]
    add_index :notifications, [:readed, :receiver_type, :receiver_id]
    add_index :notifications, :created_on
    add_index :notifications, :data, using: :gin
    add_index :notifications, :body, using: :gin, opclass: :gin_trgm_ops
    add_index :notifications, :subject, using: :gin, opclass: :gin_trgm_ops
  end
end

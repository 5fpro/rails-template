class CreateAuthorizations < ActiveRecord::Migration[7.1]
  def change
    create_table :authorizations do |t|
      t.integer :provider
      t.string  :uid
      t.string  :auth_type
      t.integer :auth_id
      t.jsonb   :auth_data, default: {}
      t.jsonb   :data, default: {}
      t.timestamps null: false
    end
    add_index :authorizations, [:provider, :uid]
    add_index :authorizations, [:auth_type, :auth_id]
    add_index :authorizations, [:auth_type, :auth_id, :provider]
    add_index :authorizations, :auth_data, using: :gin
    add_index :authorizations, :data, using: :gin
  end
end

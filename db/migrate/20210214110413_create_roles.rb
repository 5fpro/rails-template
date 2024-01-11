class CreateRoles < ActiveRecord::Migration[7.1]
  def up
    create_table :roles do |t|
      t.string :scope, comment: '區隔'
      t.string :name, comment: '名稱'
      t.string :description, comment: '描述'
      t.boolean :enabled, default: false
      t.string :permissions, array: true, comment: '擁有的權限', default: []
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :roles, :scope
    add_index :roles, [:scope, :name]
    add_index :roles, :enabled
    add_index :roles, :permissions, using: :gin
    add_index :roles, :name, using: :gin, opclass: :gin_trgm_ops
    add_index :roles, :description, using: :gin, opclass: :gin_trgm_ops
    add_index :roles, :data, using: :gin

    create_table :role_peoples do |t|
      t.integer :role_id, comment: '角色'
      t.string :people_type
      t.integer :people_id
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :role_peoples, :role_id
    add_index :role_peoples, [:people_type, :people_id]
    add_index :role_peoples, :data, using: :gin
  end

  def down
    drop_table :roles
    drop_table :role_peoples
  end
end

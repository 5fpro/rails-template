class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string  :actor_type
      t.integer :actor_id
      t.string  :action
      t.string  :target_type
      t.integer :target_id
      t.date    :acted_on
      t.jsonb   :data, default: {}
      t.timestamps
    end
    add_index :activities, [:actor_type, :actor_id]
    add_index :activities, [:target_type, :target_id]
    add_index :activities, [:action]
    add_index :activities, [:acted_on]
    add_index :activities, :data, using: :gin
  end
end

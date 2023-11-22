class CreatePageBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :page_blocks do |t|
      t.string  :name
      t.text    :body
      t.boolean :enabled, default: false
      t.string  :template_engine
      t.text    :variables
      t.jsonb   :data, default: {}
      t.timestamps
    end
    add_index :page_blocks, :name
    add_index :page_blocks, :enabled
    add_index :page_blocks, :data, using: :gin
  end
end

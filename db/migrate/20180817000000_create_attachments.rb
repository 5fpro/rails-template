class CreateAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.string  :name
      t.text    :description
      t.string  :creator_type
      t.integer :creator_id
      t.string  :item_type
      t.integer :item_id
      t.string  :scope
      t.integer :sort
      t.string  :original_filename
      t.string  :stored_filename
      t.string  :file_content_type
      t.integer :file_size
      t.integer :image_width
      t.integer :image_height
      t.jsonb   :image_exif, default: {}
      t.jsonb   :data, default: {}
      t.timestamps
    end
    add_index :attachments, [:creator_type, :creator_id]
    add_index :attachments, [:item_type, :item_id]
    add_index :attachments, [:item_type, :item_id, :sort]
    add_index :attachments, [:item_type, :item_id, :scope]
    add_index :attachments, [:item_type, :item_id, :scope, :sort]
    add_index :attachments, :image_exif, using: :gin
    add_index :attachments, :data, using: :gin
    add_index :attachments, :description, using: :gin, opclass: :gin_trgm_ops
  end
end

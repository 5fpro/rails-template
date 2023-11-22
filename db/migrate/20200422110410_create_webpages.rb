class CreateWebpages < ActiveRecord::Migration[7.1]
  def change
    create_table :webpages do |t|
      t.boolean :enabled, default: false
      t.integer :page_type, default: 0, comment: '網頁類型'
      t.integer :template_engine, default: 0, comment: '樣板引擎'
      t.string :label, comment: '名稱'
      t.string :path, comment: '網頁路徑或代號'
      t.string :context_type
      t.integer :context_id
      t.integer :layout_id, comment: '版型ID'
      t.string :title, comment: '網頁標題'
      t.text :body
      t.text :header
      t.text :footer
      t.string :meta_description
      t.text :meta_data, comment: 'meta seo 設定'
      t.text :variables, comment: '變數'
      t.string :image, comment: '分享預覽圖'
      t.string :attachment, comment: '靜態檔案'
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :webpages, :enabled
    add_index :webpages, [:context_type, :context_id]
    add_index :webpages, [:context_type, :context_id, :path]
    add_index :webpages, [:context_type, :context_id, :page_type]
    add_index :webpages, [:layout_id]
    add_index :webpages, [:layout_id, :page_type]
    add_index :webpages, :data, using: :gin
  end
end

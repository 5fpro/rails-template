class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :layout, comment: '版位'
      t.integer :article_category_id, comment: '文章分類'
      t.string :subject, comment: '標題'
      t.string :summary, comment: '摘要'
      t.text :body, comment: '內文'
      t.integer :cover_id, comment: '封面照片，attachment id'
      t.date :published_on, comment: '發佈日期'
      t.datetime :published_at, comment: '發佈日期+時間'
      t.string :author_name, comment: '作者名稱'
      t.string :author_type
      t.integer :author_id
      t.integer :status, comment: '狀態'
      t.boolean :top, default: false
      t.string :meta_title, comment: 'SEO 標題'
      t.string :meta_description, comment: 'SEO 描述'
      t.string :meta_keywords, comment: 'SEO 關鍵字'
      t.integer :total_pageviews, default: 0, comment: '總瀏覽數'
      t.datetime :deleted_at
      t.datetime :modified_at
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :articles, :layout
    add_index :articles, [:layout, :article_category_id]
    add_index :articles, [:layout, :published_on]
    add_index :articles, [:layout, :author_type, :author_id]
    add_index :articles, [:layout, :author_name]
    add_index :articles, [:layout, :status]
    add_index :articles, [:layout, :top]
    add_index :articles, [:layout, :total_pageviews]
    add_index :articles, :subject, using: :gin, opclass: :gin_trgm_ops
    add_index :articles, :body, using: :gin, opclass: :gin_trgm_ops
    add_index :articles, :summary, using: :gin, opclass: :gin_trgm_ops
    add_index :articles, :author_name, using: :gin, opclass: :gin_trgm_ops
    add_index :articles, :data, using: :gin

    create_table :article_categories do |t|
      t.string :layout, comment: '版位'
      t.string :name, comment: '名稱'
      t.boolean :enabled, default: true, comment: '是否顯示'
      t.integer :sort, comment: '排序'
      t.integer :parent_id, comment: '上層分類'
      t.integer :deep, default: 0, comment: '目前分層的深度'
      t.integer :tree_position, default: 999, comment: '樹狀結構中的位置'
      t.integer :articles_count, default: 0, comment: '文章數'
      t.datetime :deleted_at
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :article_categories, :layout
    add_index :article_categories, [:layout, :enabled]
    add_index :article_categories, [:layout, :enabled, :sort]
    add_index :article_categories, [:layout, :parent_id]
    add_index :article_categories, [:layout, :deep]
    add_index :article_categories, [:layout, :tree_position]
    add_index :article_categories, :name, using: :gin, opclass: :gin_trgm_ops
    add_index :article_categories, :data, using: :gin
  end
end

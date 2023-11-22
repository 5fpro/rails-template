class CreateArticleCategoryMapping < ActiveRecord::Migration[7.1]
  def change
    create_table :article_category_mappings do |t|
      t.integer :article_category_id, comment: '文章分類'
      t.integer :article_id, comment: '文章'
      t.integer :sort, default: 999
      t.string :layout
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :article_category_mappings, :article_category_id
    add_index :article_category_mappings, :article_id
    add_index :article_category_mappings, [:layout, :article_id]
    add_index :article_category_mappings, [:article_category_id, :article_id], name: 'tyr_article_categoy_mapping_idx'
    add_index :article_category_mappings, :data, using: :gin
  end
end

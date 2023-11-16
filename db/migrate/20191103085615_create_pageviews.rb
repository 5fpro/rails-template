class CreatePageviews < ActiveRecord::Migration[6.0]
  def change
    create_table :pageviews do |t|
      t.string :scope, comment: '範圍'
      t.string :target_type, comment: '標的類型'
      t.integer :target_id, comment: '標的 id'
      t.string :target_identity, comment: '標的識別'
      t.date :created_on, comment: '日期'
      t.string :visitor_type, comment: '瀏覽者類型'
      t.integer :visitor_id, comment: '瀏覽者 id'
      t.string :visitor_identity, comment: '瀏覽者識別'
      t.string :request_url, comment: '瀏覽網址'
      t.string :ip, comment: 'ip'
      t.string :continent, comment: '洲別'
      t.string :country, comment: '國家'
      t.string :region, comment: '區域'
      t.string :city, comment: '城市'
      t.string :zip, comment: '郵遞區號'
      t.st_point :lnglat, geographic: true, comment: '經緯度'
      t.string :referer_url, comment: '來源網址'
      t.string :referer_domain, comment: '來源網域'
      t.jsonb :params, comment: '參數', default: {}
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :pageviews, :scope
    add_index :pageviews, [:target_type, :target_id]
    add_index :pageviews, [:scope, :target_type, :target_id]
    add_index :pageviews, [:visitor_type, :visitor_id]
    add_index :pageviews, [:scope, :visitor_type, :visitor_id]
    add_index :pageviews, [:scope, :visitor_identity]
    add_index :pageviews, [:scope, :target_identity]
    add_index :pageviews, [:scope, :created_on]
    add_index :pageviews, [:scope, :referer_domain]
    add_index :pageviews, [:continent]
    add_index :pageviews, [:country]
    add_index :pageviews, [:region]
    add_index :pageviews, [:city]
    add_index :pageviews, [:country, :zip]
    add_index :pageviews, :lnglat, using: :gist
    add_index :pageviews, :target_identity, using: :gin, opclass: :gin_trgm_ops
    add_index :pageviews, :visitor_identity, using: :gin, opclass: :gin_trgm_ops
    add_index :pageviews, :request_url, using: :gin, opclass: :gin_trgm_ops
    add_index :pageviews, :referer_url, using: :gin, opclass: :gin_trgm_ops
    add_index :pageviews, :data, using: :gin
    add_index :pageviews, :params, using: :gin
  end
end

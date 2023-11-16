# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_11_17_072407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string "actor_type"
    t.integer "actor_id"
    t.string "action"
    t.string "target_type"
    t.integer "target_id"
    t.date "acted_on"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acted_on"], name: "index_activities_on_acted_on"
    t.index ["action"], name: "index_activities_on_action"
    t.index ["actor_type", "actor_id"], name: "index_activities_on_actor_type_and_actor_id"
    t.index ["data"], name: "index_activities_on_data", using: :gin
    t.index ["target_type", "target_id"], name: "index_activities_on_target_type_and_target_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "name"
    t.boolean "root", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "mfa_token"
    t.string "mfa_secret"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_administrators_on_confirmation_token", unique: true
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "amoebas", force: :cascade do |t|
    t.string "layout"
    t.jsonb "data", default: {}
    t.integer "sort"
    t.boolean "enabled", default: false
    t.datetime "datetime"
    t.date "date"
    t.integer "integer"
    t.decimal "float"
    t.string "string"
    t.text "text"
    t.boolean "boolean", default: false
    t.string "people_type"
    t.integer "people_id"
    t.string "object_type"
    t.integer "object_id"
    t.string "context_type"
    t.integer "context_id"
    t.text "configuration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["boolean"], name: "index_amoebas_on_boolean"
    t.index ["context_type", "context_id"], name: "index_amoebas_on_context_type_and_context_id"
    t.index ["data"], name: "index_amoebas_on_data", using: :gin
    t.index ["date"], name: "index_amoebas_on_date"
    t.index ["integer"], name: "index_amoebas_on_integer"
    t.index ["layout"], name: "index_amoebas_on_layout"
    t.index ["object_type", "object_id"], name: "index_amoebas_on_object_type_and_object_id"
    t.index ["people_type", "people_id"], name: "index_amoebas_on_people_type_and_people_id"
    t.index ["sort", "enabled"], name: "index_amoebas_on_sort_and_enabled"
    t.index ["sort"], name: "index_amoebas_on_sort"
    t.index ["string"], name: "index_amoebas_on_string"
  end

  create_table "article_categories", force: :cascade do |t|
    t.string "layout", comment: "版位"
    t.string "name", comment: "名稱"
    t.boolean "enabled", default: true, comment: "是否顯示"
    t.integer "sort", comment: "排序"
    t.integer "parent_id", comment: "上層分類"
    t.integer "deep", default: 0, comment: "目前分層的深度"
    t.integer "tree_position", default: 999, comment: "樹狀結構中的位置"
    t.integer "articles_count", default: 0, comment: "文章數"
    t.datetime "deleted_at"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_article_categories_on_data", using: :gin
    t.index ["layout", "deep"], name: "index_article_categories_on_layout_and_deep"
    t.index ["layout", "enabled", "sort"], name: "index_article_categories_on_layout_and_enabled_and_sort"
    t.index ["layout", "enabled"], name: "index_article_categories_on_layout_and_enabled"
    t.index ["layout", "parent_id"], name: "index_article_categories_on_layout_and_parent_id"
    t.index ["layout", "tree_position"], name: "index_article_categories_on_layout_and_tree_position"
    t.index ["layout"], name: "index_article_categories_on_layout"
    t.index ["name"], name: "index_article_categories_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "article_category_mappings", force: :cascade do |t|
    t.integer "article_category_id", comment: "文章分類"
    t.integer "article_id", comment: "文章"
    t.integer "sort", default: 999
    t.string "layout"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_category_id", "article_id"], name: "tyr_article_categoy_mapping_idx"
    t.index ["article_category_id"], name: "index_article_category_mappings_on_article_category_id"
    t.index ["article_id"], name: "index_article_category_mappings_on_article_id"
    t.index ["data"], name: "index_article_category_mappings_on_data", using: :gin
    t.index ["layout", "article_id"], name: "index_article_category_mappings_on_layout_and_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "layout", comment: "版位"
    t.integer "article_category_id", comment: "文章分類"
    t.string "subject", comment: "標題"
    t.string "summary", comment: "摘要"
    t.text "body", comment: "內文"
    t.integer "cover_id", comment: "封面照片，attachment id"
    t.date "published_on", comment: "發佈日期"
    t.datetime "published_at", comment: "發佈日期+時間"
    t.string "author_name", comment: "作者名稱"
    t.string "author_type"
    t.integer "author_id"
    t.integer "status", comment: "狀態"
    t.boolean "top", default: false
    t.string "meta_title", comment: "SEO 標題"
    t.string "meta_description", comment: "SEO 描述"
    t.string "meta_keywords", comment: "SEO 關鍵字"
    t.integer "total_pageviews", default: 0, comment: "總瀏覽數"
    t.datetime "deleted_at"
    t.datetime "modified_at"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_name"], name: "index_articles_on_author_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["body"], name: "index_articles_on_body", opclass: :gin_trgm_ops, using: :gin
    t.index ["data"], name: "index_articles_on_data", using: :gin
    t.index ["layout", "article_category_id"], name: "index_articles_on_layout_and_article_category_id"
    t.index ["layout", "author_name"], name: "index_articles_on_layout_and_author_name"
    t.index ["layout", "author_type", "author_id"], name: "index_articles_on_layout_and_author_type_and_author_id"
    t.index ["layout", "published_on"], name: "index_articles_on_layout_and_published_on"
    t.index ["layout", "status"], name: "index_articles_on_layout_and_status"
    t.index ["layout", "top"], name: "index_articles_on_layout_and_top"
    t.index ["layout", "total_pageviews"], name: "index_articles_on_layout_and_total_pageviews"
    t.index ["layout"], name: "index_articles_on_layout"
    t.index ["subject"], name: "index_articles_on_subject", opclass: :gin_trgm_ops, using: :gin
    t.index ["summary"], name: "index_articles_on_summary", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "creator_type"
    t.integer "creator_id"
    t.string "item_type"
    t.integer "item_id"
    t.string "scope"
    t.integer "sort"
    t.string "original_filename"
    t.string "stored_filename"
    t.string "file_content_type"
    t.integer "file_size"
    t.integer "image_width"
    t.integer "image_height"
    t.jsonb "image_exif", default: {}
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_type", "creator_id"], name: "index_attachments_on_creator_type_and_creator_id"
    t.index ["data"], name: "index_attachments_on_data", using: :gin
    t.index ["description"], name: "index_attachments_on_description", opclass: :gin_trgm_ops, using: :gin
    t.index ["image_exif"], name: "index_attachments_on_image_exif", using: :gin
    t.index ["item_type", "item_id", "scope", "sort"], name: "index_attachments_on_item_type_and_item_id_and_scope_and_sort"
    t.index ["item_type", "item_id", "scope"], name: "index_attachments_on_item_type_and_item_id_and_scope"
    t.index ["item_type", "item_id", "sort"], name: "index_attachments_on_item_type_and_item_id_and_sort"
    t.index ["item_type", "item_id"], name: "index_attachments_on_item_type_and_item_id"
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer "provider"
    t.string "uid"
    t.string "auth_type"
    t.integer "auth_id"
    t.jsonb "auth_data", default: {}
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_data"], name: "index_authorizations_on_auth_data", using: :gin
    t.index ["auth_type", "auth_id", "provider"], name: "index_authorizations_on_auth_type_and_auth_id_and_provider"
    t.index ["auth_type", "auth_id"], name: "index_authorizations_on_auth_type_and_auth_id"
    t.index ["data"], name: "index_authorizations_on_data", using: :gin
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid"
  end

  create_table "catalog_items", force: :cascade do |t|
    t.string "layout"
    t.integer "catalog_id"
    t.string "item_type"
    t.integer "item_id"
    t.integer "sort"
    t.integer "context_id"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalog_id"], name: "index_catalog_items_on_catalog_id"
    t.index ["context_id", "catalog_id"], name: "index_catalog_items_on_context_id_and_catalog_id"
    t.index ["context_id", "item_id", "item_type", "catalog_id"], name: "index_catalog_items_on_context_id_and_item_and_and_catalog_id"
    t.index ["context_id", "item_id", "item_type"], name: "index_catalog_items_on_context_id_and_item_id_and_item_type"
    t.index ["context_id", "layout", "sort"], name: "index_catalog_items_on_context_id_and_layout_and_sort"
    t.index ["data"], name: "index_catalog_items_on_data", using: :gin
    t.index ["item_id", "item_type", "sort"], name: "index_catalog_items_on_item_id_and_item_type_and_sort"
    t.index ["item_id", "item_type"], name: "index_catalog_items_on_item_id_and_item_type"
    t.index ["item_id", "sort"], name: "index_catalog_items_on_item_id_and_sort"
    t.index ["layout", "catalog_id"], name: "index_catalog_items_on_layout_and_catalog_id"
  end

  create_table "catalogs", force: :cascade do |t|
    t.string "layout"
    t.string "name"
    t.integer "parent_id"
    t.boolean "enabled", default: false
    t.integer "sort"
    t.integer "deep", default: 0, comment: "目前分層深度"
    t.integer "tree_position"
    t.integer "items_count", default: 0, comment: "物件數"
    t.integer "context_id"
    t.integer "creator_id"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_catalogs_on_data", using: :gin
    t.index ["layout", "context_id"], name: "index_catalogs_on_layout_and_context_id"
    t.index ["layout", "creator_id"], name: "index_catalogs_on_layout_and_creator_id"
    t.index ["layout", "deep", "sort"], name: "index_catalogs_on_layout_and_deep_and_sort"
    t.index ["layout", "enabled", "deep", "sort"], name: "index_catalogs_on_layout_and_enabled_and_deep_and_sort"
    t.index ["layout", "enabled", "parent_id"], name: "index_catalogs_on_layout_and_enabled_and_parent_id"
    t.index ["layout", "enabled", "sort"], name: "index_catalogs_on_layout_and_enabled_and_sort"
    t.index ["layout", "enabled", "tree_position"], name: "index_catalogs_on_layout_and_enabled_and_tree_position"
    t.index ["layout", "enabled"], name: "index_catalogs_on_layout_and_enabled"
    t.index ["layout"], name: "index_catalogs_on_layout"
    t.index ["name"], name: "index_catalogs_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "event_logs", force: :cascade do |t|
    t.string "event_type"
    t.string "description"
    t.string "identity"
    t.date "created_on"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_on"], name: "index_event_logs_on_created_on"
    t.index ["data"], name: "index_event_logs_on_data", using: :gin
    t.index ["event_type", "identity"], name: "index_event_logs_on_event_type_and_identity"
    t.index ["event_type"], name: "index_event_logs_on_event_type"
  end

  create_table "mylists", force: :cascade do |t|
    t.string "layout"
    t.integer "context_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "item_type"
    t.integer "item_id"
    t.integer "sort"
    t.string "item_label"
    t.string "item_identity"
    t.date "created_on"
    t.jsonb "item_data", default: {}
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["context_id", "created_on"], name: "index_mylists_on_context_id_and_created_on"
    t.index ["context_id"], name: "index_mylists_on_context_id"
    t.index ["created_on"], name: "index_mylists_on_created_on"
    t.index ["data"], name: "index_mylists_on_data", using: :gin
    t.index ["item_data"], name: "index_mylists_on_item_data", using: :gin
    t.index ["item_id"], name: "index_mylists_on_item_id"
    t.index ["item_label"], name: "index_mylists_on_item_label", opclass: :gin_trgm_ops, using: :gin
    t.index ["item_type", "item_id"], name: "index_mylists_on_item_type_and_item_id"
    t.index ["layout", "context_id", "created_on"], name: "index_mylists_on_layout_and_context_id_and_created_on"
    t.index ["layout", "owner_id", "item_id"], name: "index_mylists_on_layout_and_owner_id_and_item_id"
    t.index ["layout", "owner_id", "item_identity"], name: "index_mylists_on_layout_and_owner_id_and_item_identity"
    t.index ["layout"], name: "index_mylists_on_layout"
    t.index ["owner_id", "item_id"], name: "index_mylists_on_owner_id_and_item_id"
    t.index ["owner_id", "item_identity"], name: "index_mylists_on_owner_id_and_item_identity"
    t.index ["owner_id"], name: "index_mylists_on_owner_id"
    t.index ["owner_type", "owner_id"], name: "index_mylists_on_owner_type_and_owner_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "sender_type"
    t.string "sender_id"
    t.string "receiver_type"
    t.string "receiver_id"
    t.string "object_type"
    t.string "object_id"
    t.string "notify_type"
    t.boolean "readed", default: false
    t.string "subject"
    t.string "body"
    t.date "created_on"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["body"], name: "index_notifications_on_body", opclass: :gin_trgm_ops, using: :gin
    t.index ["created_on"], name: "index_notifications_on_created_on"
    t.index ["data"], name: "index_notifications_on_data", using: :gin
    t.index ["notify_type"], name: "index_notifications_on_notify_type"
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["readed", "receiver_type", "receiver_id"], name: "index_notifications_on_readed_and_receiver_type_and_receiver_id"
    t.index ["receiver_type", "receiver_id"], name: "index_notifications_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_notifications_on_sender_type_and_sender_id"
    t.index ["subject"], name: "index_notifications_on_subject", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "numeros", force: :cascade do |t|
    t.string "layout"
    t.string "context_type"
    t.integer "context_id"
    t.string "creator_type"
    t.integer "creator_id"
    t.string "creator_identity"
    t.integer "catalog_id"
    t.string "catalog_identity"
    t.string "subject_type"
    t.integer "subject_id"
    t.string "subject_identity"
    t.jsonb "subject_data", default: {}
    t.integer "number_type"
    t.decimal "number"
    t.date "date"
    t.datetime "datetime"
    t.integer "year"
    t.integer "month"
    t.integer "week_day"
    t.integer "hour"
    t.string "note"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_numeros_on_data", using: :gin
    t.index ["layout", "catalog_id"], name: "index_numeros_on_layout_and_catalog_id"
    t.index ["layout", "context_type", "context_id", "catalog_id"], name: "idx_numeros_on_lc_and_catalog"
    t.index ["layout", "context_type", "context_id", "catalog_identity"], name: "idx_numeros_on_lc_and_catalog_identity"
    t.index ["layout", "context_type", "context_id", "creator_id"], name: "idx_numeros_on_lc_and_creator"
    t.index ["layout", "context_type", "context_id", "creator_identity"], name: "idx_numeros_on_lc_and_creator_identity"
    t.index ["layout", "context_type", "context_id", "date"], name: "idx_numeros_on_lc_and_date"
    t.index ["layout", "context_type", "context_id", "datetime"], name: "idx_numeros_on_lc_and_datetime"
    t.index ["layout", "context_type", "context_id", "hour"], name: "idx_numeros_on_lc_and_hour"
    t.index ["layout", "context_type", "context_id", "month"], name: "idx_numeros_on_lc_and_month"
    t.index ["layout", "context_type", "context_id", "number_type"], name: "idx_numeros_on_lc_and_number_type"
    t.index ["layout", "context_type", "context_id", "subject_id"], name: "idx_numeros_on_lc_and_subject"
    t.index ["layout", "context_type", "context_id", "subject_identity"], name: "idx_numeros_on_lc_and_subject_identity"
    t.index ["layout", "context_type", "context_id", "week_day"], name: "idx_numeros_on_lc_and_week_day"
    t.index ["layout", "context_type", "context_id", "year"], name: "idx_numeros_on_lc_and_year"
    t.index ["layout", "context_type", "context_id"], name: "idx_numeros_on_layout_and_context"
    t.index ["layout", "creator_identity"], name: "index_numeros_on_layout_and_creator_identity"
    t.index ["layout", "creator_type", "creator_id"], name: "idx_numeros_on_layout_and_creator"
    t.index ["layout", "date"], name: "index_numeros_on_layout_and_date"
    t.index ["layout", "datetime"], name: "index_numeros_on_layout_and_datetime"
    t.index ["layout", "hour"], name: "index_numeros_on_layout_and_hour"
    t.index ["layout", "month"], name: "index_numeros_on_layout_and_month"
    t.index ["layout", "number_type"], name: "index_numeros_on_layout_and_number_type"
    t.index ["layout", "subject_id"], name: "index_numeros_on_layout_and_subject_id"
    t.index ["layout", "subject_identity"], name: "index_numeros_on_layout_and_subject_identity"
    t.index ["layout", "subject_type", "subject_id", "datetime"], name: "idx_numeros_on_layout_and_subject_and_datetime"
    t.index ["layout", "subject_type", "subject_id", "hour"], name: "idx_numeros_on_layout_and_subject_and_hour"
    t.index ["layout", "subject_type", "subject_id", "month"], name: "idx_numeros_on_layout_and_subject_and_month"
    t.index ["layout", "subject_type", "subject_id", "week_day"], name: "idx_numeros_on_layout_and_subject_and_week_day"
    t.index ["layout", "subject_type", "subject_id", "year"], name: "idx_numeros_on_layout_and_subject_and_year"
    t.index ["layout", "week_day"], name: "index_numeros_on_layout_and_week_day"
    t.index ["layout", "year"], name: "index_numeros_on_layout_and_year"
    t.index ["layout"], name: "index_numeros_on_layout"
    t.index ["note"], name: "index_numeros_on_note", opclass: :gin_trgm_ops, using: :gin
    t.index ["subject_data"], name: "index_numeros_on_subject_data", using: :gin
  end

  create_table "orders", force: :cascade do |t|
    t.string "layout"
    t.string "sn"
    t.string "user_type"
    t.integer "user_id"
    t.string "creator_type"
    t.integer "creator_id"
    t.string "currency"
    t.decimal "total_amount"
    t.integer "state"
    t.integer "payment_state"
    t.string "context_type"
    t.integer "context_id"
    t.text "for_text_search"
    t.date "created_on"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["context_type", "context_id", "sn"], name: "index_orders_on_context_type_and_context_id_and_sn"
    t.index ["created_on", "context_id", "context_type"], name: "index_orders_on_created_on_and_context_id_and_context_type"
    t.index ["created_on", "layout"], name: "index_orders_on_created_on_and_layout"
    t.index ["created_on"], name: "index_orders_on_created_on"
    t.index ["creator_type", "creator_id", "context_id", "context_type"], name: "index_orders_on_creator_and_context"
    t.index ["creator_type", "creator_id", "layout"], name: "index_orders_on_creator_type_and_creator_id_and_layout"
    t.index ["creator_type", "creator_id"], name: "index_orders_on_creator_type_and_creator_id"
    t.index ["data", "context_id", "context_type"], name: "index_orders_on_data_and_context_id_and_context_type", using: :gin
    t.index ["data", "layout"], name: "index_orders_on_data_and_layout", using: :gin
    t.index ["data"], name: "index_orders_on_data", using: :gin
    t.index ["for_text_search"], name: "index_orders_on_for_text_search", opclass: :gin_trgm_ops, using: :gin
    t.index ["layout", "sn"], name: "index_orders_on_layout_and_sn"
    t.index ["payment_state", "context_id", "context_type"], name: "index_orders_on_payment_state_and_context_id_and_context_type"
    t.index ["payment_state", "layout"], name: "index_orders_on_payment_state_and_layout"
    t.index ["payment_state"], name: "index_orders_on_payment_state"
    t.index ["sn"], name: "index_orders_on_sn"
    t.index ["state", "context_id", "context_type"], name: "index_orders_on_state_and_context_id_and_context_type"
    t.index ["state", "layout"], name: "index_orders_on_state_and_layout"
    t.index ["state"], name: "index_orders_on_state"
    t.index ["user_type", "user_id", "context_id", "context_type"], name: "index_orders_on_user_and_context"
    t.index ["user_type", "user_id", "layout"], name: "index_orders_on_user_type_and_user_id_and_layout"
    t.index ["user_type", "user_id"], name: "index_orders_on_user_type_and_user_id"
  end

  create_table "page_blocks", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "enabled", default: false
    t.string "template_engine"
    t.text "variables"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_page_blocks_on_data", using: :gin
    t.index ["enabled"], name: "index_page_blocks_on_enabled"
    t.index ["name"], name: "index_page_blocks_on_name"
  end

  create_table "pageviews", force: :cascade do |t|
    t.string "scope", comment: "範圍"
    t.string "target_type", comment: "標的類型"
    t.integer "target_id", comment: "標的 id"
    t.string "target_identity", comment: "標的識別"
    t.date "created_on", comment: "日期"
    t.string "visitor_type", comment: "瀏覽者類型"
    t.integer "visitor_id", comment: "瀏覽者 id"
    t.string "visitor_identity", comment: "瀏覽者識別"
    t.string "request_url", comment: "瀏覽網址"
    t.string "ip", comment: "ip"
    t.string "continent", comment: "洲別"
    t.string "country", comment: "國家"
    t.string "region", comment: "區域"
    t.string "city", comment: "城市"
    t.string "zip", comment: "郵遞區號"
    t.geography "lnglat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, comment: "經緯度"
    t.string "referer_url", comment: "來源網址"
    t.string "referer_domain", comment: "來源網域"
    t.jsonb "params", default: {}, comment: "參數"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city"], name: "index_pageviews_on_city"
    t.index ["continent"], name: "index_pageviews_on_continent"
    t.index ["country", "zip"], name: "index_pageviews_on_country_and_zip"
    t.index ["country"], name: "index_pageviews_on_country"
    t.index ["data"], name: "index_pageviews_on_data", using: :gin
    t.index ["lnglat"], name: "index_pageviews_on_lnglat", using: :gist
    t.index ["params"], name: "index_pageviews_on_params", using: :gin
    t.index ["referer_url"], name: "index_pageviews_on_referer_url", opclass: :gin_trgm_ops, using: :gin
    t.index ["region"], name: "index_pageviews_on_region"
    t.index ["request_url"], name: "index_pageviews_on_request_url", opclass: :gin_trgm_ops, using: :gin
    t.index ["scope", "created_on"], name: "index_pageviews_on_scope_and_created_on"
    t.index ["scope", "referer_domain"], name: "index_pageviews_on_scope_and_referer_domain"
    t.index ["scope", "target_identity"], name: "index_pageviews_on_scope_and_target_identity"
    t.index ["scope", "target_type", "target_id"], name: "index_pageviews_on_scope_and_target_type_and_target_id"
    t.index ["scope", "visitor_identity"], name: "index_pageviews_on_scope_and_visitor_identity"
    t.index ["scope", "visitor_type", "visitor_id"], name: "index_pageviews_on_scope_and_visitor_type_and_visitor_id"
    t.index ["scope"], name: "index_pageviews_on_scope"
    t.index ["target_identity"], name: "index_pageviews_on_target_identity", opclass: :gin_trgm_ops, using: :gin
    t.index ["target_type", "target_id"], name: "index_pageviews_on_target_type_and_target_id"
    t.index ["visitor_identity"], name: "index_pageviews_on_visitor_identity", opclass: :gin_trgm_ops, using: :gin
    t.index ["visitor_type", "visitor_id"], name: "index_pageviews_on_visitor_type_and_visitor_id"
  end

  create_table "role_peoples", force: :cascade do |t|
    t.integer "role_id", comment: "角色"
    t.string "people_type"
    t.integer "people_id"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_role_peoples_on_data", using: :gin
    t.index ["people_type", "people_id"], name: "index_role_peoples_on_people_type_and_people_id"
    t.index ["role_id"], name: "index_role_peoples_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "scope", comment: "區隔"
    t.string "name", comment: "名稱"
    t.string "description", comment: "描述"
    t.boolean "enabled", default: false
    t.string "permissions", default: [], comment: "擁有的權限", array: true
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_roles_on_data", using: :gin
    t.index ["description"], name: "index_roles_on_description", opclass: :gin_trgm_ops, using: :gin
    t.index ["enabled"], name: "index_roles_on_enabled"
    t.index ["name"], name: "index_roles_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["permissions"], name: "index_roles_on_permissions", using: :gin
    t.index ["scope", "name"], name: "index_roles_on_scope_and_name"
    t.index ["scope"], name: "index_roles_on_scope"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["data"], name: "index_users_on_data", using: :gin
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "webpages", force: :cascade do |t|
    t.boolean "enabled", default: false
    t.integer "page_type", default: 0, comment: "網頁類型"
    t.integer "template_engine", default: 0, comment: "樣板引擎"
    t.string "label", comment: "名稱"
    t.string "path", comment: "網頁路徑或代號"
    t.string "context_type"
    t.integer "context_id"
    t.integer "layout_id", comment: "版型ID"
    t.string "title", comment: "網頁標題"
    t.text "body"
    t.text "header"
    t.text "footer"
    t.string "meta_description"
    t.text "meta_data", comment: "meta seo 設定"
    t.text "variables", comment: "變數"
    t.string "image", comment: "分享預覽圖"
    t.string "attachment", comment: "靜態檔案"
    t.jsonb "data", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["context_type", "context_id", "page_type"], name: "index_webpages_on_context_type_and_context_id_and_page_type"
    t.index ["context_type", "context_id", "path"], name: "index_webpages_on_context_type_and_context_id_and_path"
    t.index ["context_type", "context_id"], name: "index_webpages_on_context_type_and_context_id"
    t.index ["data"], name: "index_webpages_on_data", using: :gin
    t.index ["enabled"], name: "index_webpages_on_enabled"
    t.index ["layout_id", "page_type"], name: "index_webpages_on_layout_id_and_page_type"
    t.index ["layout_id"], name: "index_webpages_on_layout_id"
  end

end

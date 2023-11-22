class CreateNumeros < ActiveRecord::Migration[7.1]
  def up
    create_table :numeros do |t|
      t.string :layout
      t.string :context_type
      t.integer :context_id
      t.string :creator_type
      t.integer :creator_id
      t.string :creator_identity
      t.integer :catalog_id
      t.string :catalog_identity
      t.string :subject_type
      t.integer :subject_id
      t.string :subject_identity
      t.jsonb :subject_data, default: {}
      t.integer :number_type
      t.decimal :number
      t.date :date
      t.datetime :datetime
      t.integer :year
      t.integer :month
      t.integer :week_day
      t.integer :hour
      t.string :note
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :numeros, [:layout]
    add_index :numeros, [:layout, :context_type, :context_id], name: 'idx_numeros_on_layout_and_context'
    add_index :numeros, [:layout, :context_type, :context_id, :creator_id], name: 'idx_numeros_on_lc_and_creator'
    add_index :numeros, [:layout, :creator_type, :creator_id], name: 'idx_numeros_on_layout_and_creator'
    add_index :numeros, [:layout, :context_type, :context_id, :creator_identity], name: 'idx_numeros_on_lc_and_creator_identity'
    add_index :numeros, [:layout, :creator_identity]
    add_index :numeros, [:layout, :catalog_id]
    add_index :numeros, [:layout, :context_type, :context_id, :catalog_id], name: 'idx_numeros_on_lc_and_catalog'
    add_index :numeros, [:layout, :context_type, :context_id, :catalog_identity], name: 'idx_numeros_on_lc_and_catalog_identity'
    add_index :numeros, [:layout, :subject_id]
    add_index :numeros, [:layout, :context_type, :context_id, :subject_id], name: 'idx_numeros_on_lc_and_subject'
    add_index :numeros, [:layout, :subject_identity]
    add_index :numeros, [:layout, :context_type, :context_id, :subject_identity], name: 'idx_numeros_on_lc_and_subject_identity'
    add_index :numeros, [:layout, :number_type]
    add_index :numeros, [:layout, :context_type, :context_id, :number_type], name: 'idx_numeros_on_lc_and_number_type'
    add_index :numeros, [:layout, :date]
    add_index :numeros, [:layout, :context_type, :context_id, :date], name: 'idx_numeros_on_lc_and_date'
    add_index :numeros, [:layout, :datetime]
    add_index :numeros, [:layout, :year]
    add_index :numeros, [:layout, :month]
    add_index :numeros, [:layout, :week_day]
    add_index :numeros, [:layout, :hour]
    add_index :numeros, [:layout, :subject_type, :subject_id, :datetime], name: 'idx_numeros_on_layout_and_subject_and_datetime'
    add_index :numeros, [:layout, :subject_type, :subject_id, :year], name: 'idx_numeros_on_layout_and_subject_and_year'
    add_index :numeros, [:layout, :subject_type, :subject_id, :month], name: 'idx_numeros_on_layout_and_subject_and_month'
    add_index :numeros, [:layout, :subject_type, :subject_id, :week_day], name: 'idx_numeros_on_layout_and_subject_and_week_day'
    add_index :numeros, [:layout, :subject_type, :subject_id, :hour], name: 'idx_numeros_on_layout_and_subject_and_hour'
    add_index :numeros, [:layout, :context_type, :context_id, :datetime], name: 'idx_numeros_on_lc_and_datetime'
    add_index :numeros, [:layout, :context_type, :context_id, :year], name: 'idx_numeros_on_lc_and_year'
    add_index :numeros, [:layout, :context_type, :context_id, :month], name: 'idx_numeros_on_lc_and_month'
    add_index :numeros, [:layout, :context_type, :context_id, :week_day], name: 'idx_numeros_on_lc_and_week_day'
    add_index :numeros, [:layout, :context_type, :context_id, :hour], name: 'idx_numeros_on_lc_and_hour'
    add_index :numeros, :subject_data, using: :gin
    add_index :numeros, :data, using: :gin
    add_index :numeros, :note, using: :gin, opclass: :gin_trgm_ops
  end

  def down
    drop_table :numeros
  end
end

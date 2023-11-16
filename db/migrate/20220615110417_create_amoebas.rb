class CreateAmoebas < ActiveRecord::Migration[6.0]
  def up
    create_table :amoebas do |t|
      t.string :layout
      t.jsonb :data, default: {}
      t.integer :sort
      t.boolean :enabled, default: false
      t.datetime :datetime
      t.date :date
      t.integer :integer
      t.decimal :float
      t.string :string
      t.text :text
      t.boolean :boolean, default: false
      t.string :people_type
      t.integer :people_id
      t.string :object_type
      t.integer :object_id
      t.string :context_type
      t.integer :context_id
      t.text :configuration
      t.timestamps
    end

    add_index :amoebas, :data, using: :gin
    add_index :amoebas, :date
    add_index :amoebas, :integer
    add_index :amoebas, :string
    add_index :amoebas, :boolean
    add_index :amoebas, :layout
    add_index :amoebas, [:people_type, :people_id]
    add_index :amoebas, [:object_type, :object_id]
    add_index :amoebas, [:context_type, :context_id]
    add_index :amoebas, [:sort, :enabled]
    add_index :amoebas, :sort
  end

  def down
    drop_table :amoebas
  end
end

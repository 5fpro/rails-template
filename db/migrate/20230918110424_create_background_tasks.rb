class CreateBackgroundTasks < ActiveRecord::Migration[7.1]
  def up
    create_table :background_tasks do |t|
      t.string :context_type
      t.integer :context_id
      t.string :creator_type
      t.integer :creator_id
      t.integer :task_type, default: 0
      t.string :file_encoding, default: 'UTF-8'
      t.string :download_url
      t.string :download_file_name
      t.integer :status, default: 0
      t.boolean :has_error, default: false
      t.string :perform_klass
      t.string :perform_method
      t.jsonb :perform_data, default: {}
      t.string :job_identity
      t.datetime :processing_at
      t.datetime :finished_at
      t.jsonb :on_success, default: {}
      t.jsonb :on_fail, default: {}
      t.jsonb :result_data, default: {}
      t.jsonb :error_data, default: {}
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :background_tasks, [:context_type, :context_id]
    add_index :background_tasks, [:creator_type, :creator_id]
    add_index :background_tasks, :task_type
    add_index :background_tasks, :status
    add_index :background_tasks, [:context_type, :context_id, :status], name: 'index_bt_on_context_and_status'
    add_index :background_tasks, :has_error
    add_index :background_tasks, [:status, :job_identity]
    add_index :background_tasks, [:context_type, :context_id, :status, :job_identity], name: 'index_bt_on_context_and_status_and_job_identity'
    add_index :background_tasks, :result_data, using: :gin
    add_index :background_tasks, :error_data, using: :gin
    add_index :background_tasks, :data, using: :gin
    add_index :background_tasks, :on_fail, using: :gin
    add_index :background_tasks, :on_success, using: :gin
    add_index :background_tasks, :perform_data, using: :gin
  end

  def down
    drop_table :background_tasks
  end
end

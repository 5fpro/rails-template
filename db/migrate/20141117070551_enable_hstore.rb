class EnableHstore < ActiveRecord::Migration[6.0]
  def up
    execute 'CREATE EXTENSION hstore'
  end

  def down
    execute 'DROP EXTENSION hstore'
  end
end

class EnableHstore < ActiveRecord::Migration[7.1]
  def up
    execute 'CREATE EXTENSION hstore'
  end

  def down
    execute 'DROP EXTENSION hstore'
  end
end

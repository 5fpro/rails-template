class EnableExtensionPgTrgm < ActiveRecord::Migration[7.1]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
    execute 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'
    execute 'CREATE EXTENSION IF NOT EXISTS btree_gin;'
    execute 'CREATE EXTENSION IF NOT EXISTS btree_gist;'
  end

  def down
    execute 'DROP EXTENSION IF EXISTS fuzzystrmatch'
    execute 'DROP EXTENSION IF EXISTS pg_trgm'
    execute 'DROP EXTENSION IF EXISTS btree_gin;'
    execute 'DROP EXTENSION IF EXISTS btree_gist;'
  end
end

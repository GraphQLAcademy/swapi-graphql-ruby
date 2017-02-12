# weird issue with heroku + postgres referential integrity
# http://pvcarrera.github.io/general/2016/02/15/rails-fixtures-and-referencial-integrity.html

namespace :db do
  desc 'Reset and populate sample data'
  task load_swapi_fixtures: [:reset, :drop_constraints, 'fixtures:load', :create_constraints] do
    puts 'Fixtures loaded in the database'
  end

  desc 'Remove all database constraints'
  task drop_constraints: [:environment, :create_constraints_script, :drop_constraints_script] do
    ActiveRecord::Base.connection.execute(IO.read('tmp/drop_constraints.sql'))
    puts 'Constraints dropped'
  end

  desc 'Recreate database constraints'
  task create_constraints: [:environment, :create_constraints_script, :drop_constraints_script] do
    ActiveRecord::Base.connection.execute(IO.read('tmp/create_constraints.sql'))
    puts 'Constraints recreated'
  end

  file drop_constraints_script: :environment do
    query = (<<-SQL)
      SELECT 'ALTER TABLE "'||nspname||'"."'||relname||'" DROP CONSTRAINT "'||conname||'";'
        FROM pg_constraint
        INNER JOIN pg_class ON conrelid=pg_class.oid
        INNER JOIN pg_namespace ON pg_namespace.oid=pg_class.relnamespace
        ORDER BY CASE WHEN contype='f' THEN 0 ELSE 1 END,contype,nspname,relname,conname
    SQL
    array_to_file(ActiveRecord::Base.connection.execute(query), 'drop_constraints.sql')
  end

  file create_constraints_script: :environment do
    query = (<<-SQL)
      SELECT 'ALTER TABLE "'||nspname||'"."'||relname||'" ADD CONSTRAINT "'||conname||'" '|| pg_get_constraintdef(pg_constraint.oid)||';'
       FROM pg_constraint
       INNER JOIN pg_class ON conrelid=pg_class.oid
       INNER JOIN pg_namespace ON pg_namespace.oid=pg_class.relnamespace
       ORDER BY CASE WHEN contype='f' THEN 0 ELSE 1 END DESC,contype DESC,nspname DESC,relname DESC,conname DESC
    SQL
    array_to_file(ActiveRecord::Base.connection.execute(query), 'create_constraints.sql')
  end

  def array_to_file(array, file_name)
    Dir.mkdir('tmp') unless File.exist?('tmp')
    File.open("tmp/#{file_name}", 'w+') do |f|
      f.puts(array.values.flatten)
    end
  end
end

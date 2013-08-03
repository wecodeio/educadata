MIGRATIONS_DIR = "db/migrations"

namespace :db do
  require_relative "config/initializers/sequel"

  Sequel.extension(:migration)

  desc 'run pending migrations - e.g. rake "db:migrate[201306261051]"'
  task :migrate, :migration do |t, args|
    target_migration = args[:migration] ? args[:migration].to_i : nil
    Sequel::Migrator.apply(DB, MIGRATIONS_DIR, target_migration)
  end

  desc "rollback all database migrations"
  task :reset do
    Sequel::Migrator.apply(DB, MIGRATIONS_DIR, 0)
    Sequel::Migrator.apply(DB, MIGRATIONS_DIR)
  end
end

namespace :g do
  task :migration, :fname do |t, args|
    require "fileutils"

    args.with_defaults(fname: "new_migration")
    Dir.chdir(MIGRATIONS_DIR) do
      timestamp = Time.now.strftime("%Y%m%d%H%M")
      filename = "#{timestamp}_#{args[:fname]}.rb"
      File.open(filename, "w") do |f|
        f << <<SCAFFOLD
Sequel.migration do
  up do
  end

  down do
  end
end
SCAFFOLD
      end
    end
  end
end

task default: :"db:migrate"

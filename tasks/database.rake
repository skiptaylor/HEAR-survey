namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      Sequel::Migrator.run db,
                           "#{File.dirname(__FILE__)}/../migrations",
                           target: args[:version].to_i
    else
      Sequel::Migrator.run db, "#{File.dirname(__FILE__)}/../migrations"
    end
  end

  desc 'Run seeds'
  task :seed do
    require 'csv'
    Dir["#{File.dirname(__FILE__)}/../seeds/**/*.rb"].each do |file|
      require file
    end
  end

  desc 'Resets, migrates, and seeds the DB'
  task :rebuild do
    Rake::Task["db:migrate"].invoke(0)
    Rake::Task["db:migrate"].reenable
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end

namespace :db do
  desc "Print the migrated migrations"
  task :schema_migrations => :environment do
    puts ActiveRecord::Base.connection.select_values('select version from schema_migrations order by version')
  end
end
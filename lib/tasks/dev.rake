namespace :dev do

  desc 'Rebuild from schema.rb'
  task build: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'Rebuild from migrations'
  task rebuild: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'generate fake data for development'
  task fake: :environment do
    FakeDataContext.new.perform
  end

end

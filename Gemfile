source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.6.6'

gem 'rails', '~> 5.2'
gem 'tyr', path: 'tyr'

gem 'activerecord-postgis-adapter'
gem 'pg'
gem 'webpacker', '~> 4.x'

# assets
gem 'coffee-rails'
gem 'sassc-rails'
gem 'uglifier'

# JS plugin
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

group :development do
  # capistrano
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-git-with-submodules'
  gem 'capistrano-nvm', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'capistrano-yarn'
  # slack
  gem 'slackistrano', require: false

  gem 'annotate'
  gem 'brakeman', '~> 4'
  gem 'http_logger'
  gem 'listen'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  gem 'rails_real_favicon'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'rspec'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'timecop'
  gem 'turnip'
  gem 'webmock'
end

# unicorn
gem 'unicorn'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'omniauth-line', git: 'git@github.com:marsz/omniauth-line.git'

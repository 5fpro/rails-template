source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.7'

gem 'rails', '~> 6.0'
gem 'tyr', path: 'tyr'

gem 'activerecord-postgis-adapter'
gem 'pg'
gem 'webpacker', '~> 5.4.4'

# assets
gem 'uglifier'

group :development do
  gem 'annotate'
  # capistrano
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-git-with-submodules'
  gem 'capistrano-nvm', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-yarn'
  # slack
  gem 'slackistrano', require: false

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

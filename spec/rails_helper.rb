# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'tyr/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!

  config.before(:each, type: :request) { host! ENV['APP_HOST'] }
  config.include RequestHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
end

Dir[Rails.root.join("spec/config/**/*.rb")].each { |f| require f }

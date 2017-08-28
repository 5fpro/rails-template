Turnip.type = :request
require 'rails_helper'
Dir[Rails.root.join('spec/steps/**/*_steps.rb')].each { |f| load f }

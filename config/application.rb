require_relative 'boot'

require 'rails'
# require 'rails/all'
require 'active_record/railtie'
require 'active_model/railtie'
require 'action_controller/railtie'
require 'active_job/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'action_cable/engine' # 為了讓 manifest.js link 的檔案可以支援 .erb

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Myapp
  class Application < Rails::Application
    ::Tyr.init_requires!

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.delivery_method = :aws_sdk

    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation cannot be found).
    config.i18n.fallbacks = [I18n.default_locale]
    config.i18n.default_locale = :'zh-TW'

    # Disable some file generators
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.helper = false
    config.generators.helper_specs = false

    config.active_job.queue_adapter = :sidekiq

    # serve error pages from the Rails app itself (routes.rb)
    config.exceptions_app = self.routes
  end
end

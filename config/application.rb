# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'rack-cas/session_store/active_record'

module NationalBudgets
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # recommended to be set to false in :zeitwerk mode early
    config.add_autoload_paths_to_load_path = false

    config.rack_cas.server_url = Rails.application.secrets.cas_server
    config.rack_cas.session_store = RackCAS::ActiveRecordStore
  end
end

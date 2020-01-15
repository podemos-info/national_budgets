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
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded af  ter loading
    # the framework and any gems in your application.
    eager_load_paths = %w[app/models/**/].freeze
    config.eager_load_paths += Dir[*eager_load_paths]

    config.rack_cas.server_url = Rails.application.secrets.cas_server
    config.rack_cas.session_store = RackCAS::ActiveRecordStore
    config.rack_cas.renew = false # default: false
  end
end

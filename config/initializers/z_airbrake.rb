# frozen_string_literal: true

Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = %w[test development]
  config.host = ENV['AIRBRAKE_HOST']
  config.project_id = ENV['AIRBRAKE_PROJECT_ID']
  config.project_key = ENV['AIRBRAKE_API_KEY']
  config.root_directory = Rails.root
  config.logger = Rails.logger
  config.blacklist_keys = Rails.application.config.filter_parameters
end

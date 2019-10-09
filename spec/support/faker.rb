# frozen_string_literal: true

if defined?(Faker)
  # we only set this in environments that support fixture/factory data
  # (i.e. currently development, test and staging)
  DEFAULT_PASSWORD = '12345678' unless defined?(DEFAULT_PASSWORD)

  I18n.enforce_available_locales = false # faker questionably sets this to true
  Faker::Config.locale = :de
end

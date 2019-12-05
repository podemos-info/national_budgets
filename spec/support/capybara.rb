# frozen_string_literal: true

require 'capybara/apparition'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :apparition

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new(app, window_size: [1280, 720], inspector: true)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do |sample|
    if sample.metadata[:js]
      driven_by :apparition
    else
      driven_by :rack_test
    end
  end
end

# frozen_string_literal: true

source 'https://rubygems.org'
#git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'activeadmin'
gem 'airbrake'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'colorize'
gem 'devise'
gem 'devise-i18n'
gem 'directorio_client', require: true, git:'https://TU_AUTHTOKEN_DE_GITHUB:x-oauth-basic@github.com/podemos-info/directorio_client'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cas'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'rails-i18n', '~> 6.0.0'
gem 'sablon'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano', '~> 3.11.0', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-systemd-multiservice', require: false
  gem 'i18n-debug'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rubocop', '~> 0.74.0', require: false
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'apparition'
  gem 'capybara', '>= 2.15'
  gem 'capybara-screenshot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.17.1', require: false
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

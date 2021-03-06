# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo|
  repo = "#{repo}/#{repo}" unless repo.include?('/')
  "git@github.com:#{repo}.git"
end

ruby '2.6.3'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'activeadmin'
gem 'airbrake'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form', '~> 4.0'
gem 'coffee-rails', '~> 5.0'
gem 'colorize'
gem 'devise'
gem 'devise-i18n'
gem 'directorio_client', require: true, github: 'podemos-info/directorio_client'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cas'
gem 'rails', '~> 6.0.0'
gem 'rails-i18n', '~> 6.0.0'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

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
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.17.1', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

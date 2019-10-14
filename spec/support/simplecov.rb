# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Admin', 'app/admin'
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { Faker::Internet.user_name }
    full_name { Faker::Name.name }
    role { %i[super_admin admin editor].sample }
    email { Faker::Internet.email }
    password { 'password' }
  end
end

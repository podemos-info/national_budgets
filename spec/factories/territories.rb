# frozen_string_literal: true

FactoryBot.define do
  factory :territory do
    territory_id { Faker::Number.unique.rand_in_range(1, 1000) }
  end

  factory :country, class: :'territories/country', parent: :territory do
    iso { Faker::Address.country_code }
    name { Faker::Address.country }
    parent_id { nil }
  end

  factory :community, class: :'territories/community', parent: :territory do
    address = Faker::Address
    iso { address.state_abbr }
    name { address.state }
    parent_id { create(:country) }
  end

  factory :province, class: :'territories/province', parent: :territory do
    address = Faker::Address
    iso { I18n.transliterate(address.province.gsub("\s", '').upcase[0..3]) }
    name { address.province }
    parent_id { create(:community) }
  end
end

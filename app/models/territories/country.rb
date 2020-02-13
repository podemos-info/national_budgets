# frozen_string_literal: true

module Territories
  class Country < Territory
    has_many :comunities,
             class_name: 'Territories::Comunity',
             foreign_key: :parent_id,
             dependent: :nullify,
             inverse_of: :country
    has_many :provinces, through: :comunities
  end
end

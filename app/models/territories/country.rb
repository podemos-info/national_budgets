# frozen_string_literal: true

module Territories
  class Country < Territory
    has_many :communities,
             class_name: 'Territories::Community',
             foreign_key: :parent_id,
             dependent: :nullify,
             inverse_of: :country
    has_many :provinces, through: :communities
  end
end

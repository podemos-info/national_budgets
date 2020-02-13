# frozen_string_literal: true

module Territories
  class Comunity < Territory
    has_many :provinces,
             class_name: 'Territories::Province',
             foreign_key: :parent_id,
             dependent: :nullify,
             inverse_of: :comunity
    belongs_to :country,
               class_name: 'Territories::Country',
               foreign_key: :parent_id,
               inverse_of: :comunities
  end
end

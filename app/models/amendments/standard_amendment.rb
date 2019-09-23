# frozen_string_literal: true

module Amendments
  class StandardAmendment < Amendment
    has_many :modifications, foreign_key: 'amendment_id', class_name: 'Modifications::StandardModification'

    def allow_modifications?
      true
    end
  end
end

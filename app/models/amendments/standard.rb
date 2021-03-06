# frozen_string_literal: true

module Amendments
  class Standard < Amendment
    def self.allowed_modifications_str
      [
        'Modifications::Addition',
        'Modifications::Removal'
      ]
    end

    include HasModifications
    include HasModificationProgram
    include HasModificationSection

    def self.position
      1
    end

    def self.modifications_allowed_new_fields
      { addition: %i[program concept subconcept],
        removal: [] }
    end
  end
end

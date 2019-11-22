# frozen_string_literal: true

module Amendments
  class StandardAmendment < Amendment
    def self.allowed_modifications_str
      [
        'Modifications::AdditionModification',
        'Modifications::RemovalModification'
      ]
    end

    include HasModifications
    include HasModificationSection

    def self.position
      1
    end

    def completed?
      any_modifications? && balance.zero?
    end
  end
end

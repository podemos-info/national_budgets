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
    include HasModificationSection

    def self.position
      1
    end
  end
end

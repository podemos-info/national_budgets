# frozen_string_literal: true

module Modifications
  class OrganismBudgetExpenditureModification < Modification
    def amount=(_value)
      self[:amount] = 0
    end

    def self.position
      4
    end
  end
end

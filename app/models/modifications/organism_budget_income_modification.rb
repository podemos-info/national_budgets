# frozen_string_literal: true

module Modifications
  class OrganismBudgetIncomeModification < Modification
    def amount=(_value)
      self[:amount] = 0
    end

    def self.position
      3
    end
  end
end

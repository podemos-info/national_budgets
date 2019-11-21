# frozen_string_literal: true

module Modifications
  class OrganismBudgetIncomeModification < Modification
    def amount=(_value)
      self[:amount] = 0
    end

    def total_amount
      0
    end

    def balance_amount
      0
    end

    def display_amount
      amendment.total_amount
    end

    def self.position
      3
    end

    def self.next_modification_type_for?(amendment)
      amendment.removal_modifications.size.positive? &&
        amendment.balance.zero? &&
        amendment.addition_modifications.any? &&
        amendment.organism_budget_income_modifications.none?
    end

    def self.disabled_modification_type_for?(amendment)
      amendment.organism_budget_income_modifications.any?
    end
  end
end

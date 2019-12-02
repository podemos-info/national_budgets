# frozen_string_literal: true

module Modifications
  class OrganismBudgetExpenditureModification < Modification
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
      -amendment.total_amount
    end

    def self.position
      4
    end

    def self.next_modification_type_for?(amendment)
      amendment.organism_budget_expenditure_modifications.none?
    end

    def self.disabled_modification_type_for?(amendment)
      amendment.organism_budget_expenditure_modifications.any? || amendment.organism_budget_income_modifications.none?
    end

    def self.present_fields
      %i[section organism program chapter]
    end
  end
end

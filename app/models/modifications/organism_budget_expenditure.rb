# frozen_string_literal: true

module Modifications
  class OrganismBudgetExpenditure < Modification
    include HasOrganism

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
      amendment.organism_budget_expenditures.none?
    end

    def self.disabled_modification_type_for?(amendment)
      amendment.organism_budget_expenditures.any? || amendment.organism_budget_incomes.none?
    end

    def self.present_fields
      %i[section organism program chapter]
    end
  end
end

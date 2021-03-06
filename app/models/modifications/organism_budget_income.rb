# frozen_string_literal: true

module Modifications
  class OrganismBudgetIncome < Modification
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
      amendment.total_amount
    end

    def self.position
      3
    end

    def self.next_modification_type_for?(amendment)
      amendment.organism_budget_incomes.none?
    end

    def self.disabled_modification_type_for?(amendment)
      amendment.organism_budget_incomes.any? || !amendment.section
    end

    def self.present_fields
      %i[section organism chapter]
    end
  end
end

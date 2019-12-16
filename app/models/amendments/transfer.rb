# frozen_string_literal: true

module Amendments
  class Transfer < Amendment
    def self.allowed_modifications_str
      [
        'Modifications::Addition',
        'Modifications::Removal',
        'Modifications::OrganismBudgetIncome',
        'Modifications::OrganismBudgetExpenditure'
      ]
    end

    include HasModifications
    include HasModificationSection
    include HasModificationOrganism

    def self.position
      2
    end

    def locked_organism?
      organism_budget_incomes.any? || organism_budget_expenditures.any?
    end

    def self.filtered_sections(sections)
      sections.joins(:organisms).distinct
    end

    def self.filtered_programs(programs, modification_class)
      programs.where(programs_filter[modification_class.name.to_sym])
    end

    def self.programs_filter
      { 'Modifications::Addition': ['ref = ?', '000X'],
        'Modifications::Removal': ['ref != ?', '000X'],
        'Modifications::OrganismBudgetIncome': nil,
        'Modifications::OrganismBudgetExpenditure': nil }
    end

    def self.modifications_allowed_new_fields
      { addition: [],
        removal: [],
        organism_budget_income: %i[concept subconcept],
        organism_budget_expenditure: %i[concept subconcept] }
    end
  end
end

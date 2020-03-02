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
    include HasModificationOrganism
    include HasModificationProgram
    include HasModificationSection

    def self.position
      2
    end

    def self.filtered_sections(sections)
      sections.joins(:organisms).distinct
    end

    def self.filtered_programs(programs, modification_type)
      case modification_type
      when :addition then programs.where(ref: '000X')
      when :removal then programs.where.not(ref: '000X')
      else programs
      end
    end

    def self.modifications_allowed_new_fields
      { addition: [],
        removal: [],
        organism_budget_income: %i[concept subconcept],
        organism_budget_expenditure: %i[concept subconcept] }
    end
  end
end

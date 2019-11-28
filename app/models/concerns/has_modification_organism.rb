# frozen_string_literal: true

module HasModificationOrganism
  extend ActiveSupport::Concern

  included do
    delegate :organism, to: :first_organism_budget_income_modification, allow_nil: true
  end

  def first_organism_budget_income_modification
    organism_budget_income_modifications.first
  end
end

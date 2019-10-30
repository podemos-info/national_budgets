# frozen_string_literal: true

module HasAmendmentBudget
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    validate :section_budget_does_not_match, if: -> { section && amendment }
  end

  def section_budget_does_not_match
    errors.add(:section, t('activerecord.errors.section_budget_does_not_match')) if section.budget != amendment.budget
  end
end

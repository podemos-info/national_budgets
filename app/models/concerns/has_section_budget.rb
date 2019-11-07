# frozen_string_literal: true

module HasSectionBudget
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do
    validate :section_budget_does_not_match, if: -> { section && amendment }
  end

  def section_budget_does_not_match
    errors.add(:section, I18n.t('activerecord.errors.section_budget_does_not_match')) if section.budget != amendment.budget
  end
end

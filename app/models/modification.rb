# frozen_string_literal: true

class Modification < ApplicationRecord
  include HasType
  include HasSectionBudget
  belongs_to :amendment, optional: false
  belongs_to :section, optional: false
  belongs_to :service, optional: false
  belongs_to :program, optional: false
  belongs_to :chapter, optional: false
  belongs_to :article, optional: false
  belongs_to :concept, optional: true
  belongs_to :subconcept, optional: true
  after_initialize :initialize_section
  validate :section_locked, if: :amendment
  validate :chapter_budget_does_not_match, if: -> { chapter && amendment }
  delegate :budget, to: :amendment, allow_nil: true

  def chapter_budget_does_not_match
    errors.add(:chapter, I18n.t('activerecord.errors.chapter_budget_does_not_match')) if chapter.budget != amendment.budget
  end

  def locked_section?
    @locked_section ||= amendment.modifications.where.not(id: id).count.positive?
  end

  def section_locked
    errors.add(:section, I18n.t('activerecord.errors.section_locked')) if locked_section? && section != amendment.section
  end

  def amount
    super || 0
  end

  alias :balance_amount :amount
  alias :display_amount :amount
  alias :total_amount :amount

  def locked_type?
    persisted?
  end

  def self.disabled_modification_type_for?(amendment)
    false
  end

  def self.next_modification_type_for?(amendment)
    false
  end

  def modification_detail?
    !locked_type?
  end

  private

  def initialize_section
    self.section ||= amendment&.section if new_record?
  end
end

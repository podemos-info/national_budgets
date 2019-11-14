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
  validates :abs_amount, presence: true
  validate :section_locked, if: :amendment
  validate :chapter_budget_does_not_match, if: -> { chapter && amendment }
  delegate :budget, to: :amendment, allow_nil: true

  scope :additions_first, -> { order(Arel.sql('amount >= 0 desc'), id: :asc) }

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

  def type=(value)
    super(value)
    sync_amount(value.constantize.new.amount_sign)
  end

  def abs_amount
    @abs_amount ||= amount&.abs
  end

  def abs_amount=(value)
    self[:amount] = @abs_amount = value.to_f.abs
    sync_amount(type.constantize.new.amount_sign) if type
  end

  def amount_sign; end

  private

  def initialize_section
    self.section ||= amendment&.section if new_record?
  end

  def sync_amount(sign)
    self[:amount] = "#{sign}#{abs_amount}".to_f
  end
end

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
  validates :type, :abs_amount, presence: true
  validate :section_not_unique, on: :update, if: -> { amendment && amendment.modifications.size > 1 }
  validate :section_not_unique, on: :create, if: :amendment
  validate :chapter_budget_does_not_match, if: -> { chapter && amendment }

  scope :additions_first, -> { order(Arel.sql('amount >= 0'), id: :asc) }

  def chapter_budget_does_not_match
    errors.add(:chapter, I18n.t('activerecord.errors.chapter_budget_does_not_match')) if chapter.budget != amendment.budget
  end

  def locked_section?
    @locked_section ||= amendment.modifications.where.not(id: id).count.positive?
  end

  def section_not_unique
    errors.add(:section, I18n.t('activerecord.errors.section_not_unique')) if amendment.section && section != amendment.section
  end

  def amount
    super || 0
  end

  def amount=(value)
    @amount_sign = @abs_amount = nil
    super(value)
  end

  def abs_amount
    @abs_amount ||= amount&.abs
  end

  def abs_amount=(value)
    @abs_amount = value.to_f.abs
    sync_amount
  end

  def amount_sign
    @amount_sign ||= amount&.negative? ? '-' : '+'
  end

  def amount_sign=(sign)
    @amount_sign = sign
    sync_amount
  end

  def amount_sign_human
    { '+' => :addition, '-' => :removal }[amount_sign]
  end

  private

  def initialize_section
    self.section ||= amendment&.section if new_record?
  end

  def sync_amount
    self[:amount] = "#{amount_sign}#{abs_amount}".to_f
  end
end

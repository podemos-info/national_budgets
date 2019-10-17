# frozen_string_literal: true

class Modification < ApplicationRecord
  include HasType
  belongs_to :amendment
  belongs_to :section
  belongs_to :service
  belongs_to :program
  belongs_to :chapter
  belongs_to :article
  belongs_to :concept, optional: true
  belongs_to :subconcept, optional: true
  after_initialize :set_section
  validates :type, :amount_sign, :amount, presence: true
  validate :section_not_unique

  def locked_section?
    @locked_section ||= amendment.modifications.where.not(id: id).count.positive?
  end

  def section_not_unique
    errors.add(:section, 'is not unique in the amendment') if amendment.section && section != amendment.section
  end

  def abs_amount
    amount&.abs
  end

  def amount_sign
    @amount_sign ||= ('++-'[amount <=> 0] if amount && persisted?)
  end

  def amount_sign=(sign)
    @amount_sign = sign
    self.amount = "#{sign}#{amount.abs}".to_f
  end

  def amount_sign_human
    { '+' => :addition, '-' => :removal }[amount_sign]
  end

  private

  def set_section
    self.section ||= amendment&.section if new_record?
  end
end

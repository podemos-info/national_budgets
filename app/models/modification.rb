# frozen_string_literal: true

class Modification < ApplicationRecord
  belongs_to :amendment
  belongs_to :section
  belongs_to :service
  belongs_to :program
  belongs_to :chapter
  belongs_to :article
  belongs_to :concept, optional: true
  belongs_to :subconcept, optional: true
  after_initialize :set_section
  validate :section_not_unique

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end

  def locked_section?
    @locked_section ||= amendment.modifications.where.not(id: id).count.positive?
  end

  def section_not_unique
    errors.add(:section, 'is not unique in the amendment') if amendment.section && section != amendment.section
  end

  private

  def set_section
    self.section ||= amendment&.section if new_record?
  end
end

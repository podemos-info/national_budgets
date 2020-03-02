# frozen_string_literal: true

class Modification < ApplicationRecord
  include HasType
  include HasSectionBudget
  belongs_to :amendment, optional: false
  belongs_to :section, optional: false
  belongs_to :service, optional: true
  belongs_to :program, optional: true
  belongs_to :organism, optional: true
  belongs_to :chapter, optional: false
  belongs_to :article, optional: false
  belongs_to :concept, optional: true
  belongs_to :subconcept, optional: true
  after_initialize :initialize_section
  validate :section_locked, if: :amendment
  validate :program_locked, if: :amendment
  validate :organism_locked, if: :amendment
  validate :chapter_budget_does_not_match, if: -> { chapter && amendment }
  delegate :budget, to: :amendment, allow_nil: true

  def self.present_fields; end

  def use_field?(field)
    self.class.use_field?(field)
  end

  def self.use_field?(field)
    present_fields.member?(field)
  end

  def chapter_budget_does_not_match
    errors.add(:chapter, I18n.t('activerecord.errors.chapter_budget_does_not_match')) if chapter.budget != amendment.budget
  end

  def locked_section?
    @locked_section ||= amendment.modifications.where.not(id: id).count.positive?
  end

  def section_locked
    return unless locked_section? && section != amendment.section

    errors.add(:section, I18n.t('activerecord.errors.field_locked_female'))
  end

  def organism_locked
    return unless use_field?(:organism) && locked_organism? && organism != amendment.organism

    errors.add(:organism, I18n.t('activerecord.errors.field_locked_male'))
  end

  def locked_organism?
    amendment&.locked_organism?(self)
  end

  def program_locked
    return unless is_a?(Modifications::Addition) && locked_program?(self.class) && program != amendment.program

    errors.add(:program, I18n.t('activerecord.errors.field_locked_male'))
  end

  def locked_program?(modification_class)
    amendment&.locked_program?(modification_class, self)
  end

  def amount
    super || 0
  end

  alias balance_amount amount
  alias display_amount amount
  alias total_amount amount

  def locked_type?
    persisted?
  end

  def self.disabled_modification_type_for?(_amendment)
    false
  end

  def self.next_modification_type_for?(_amendment); end

  def self.to_param
    name.demodulize.underscore
  end

  private

  def initialize_section
    self.section ||= amendment&.section if new_record?
  end
end

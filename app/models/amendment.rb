# frozen_string_literal: true

class Amendment < ApplicationRecord
  include HasType
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :territory, optional: false

  validates :number, :explanation, presence: true
  validates :number, uniqueness: { scope: :budget }
  validate :type_locked, on: :update, if: :locked_type?

  before_validation :set_number_default, unless: :persisted?
  before_validation :set_number, if: :territory_id_changed?

  scope :by_number_base, lambda { |number_base, number_base_with_sep, id|
                           where('(number = ? OR number LIKE ?) AND id != ?',
                                 number_base, "#{number_base_with_sep}%", id)
                         }

  def any_modifications?; end

  def allow_modifications?; end

  def any_articulated?
    false
  end

  def allow_articulated?; end

  def completed?; end

  def locked_type?
    persisted? && (any_articulated? || any_modifications?)
  end

  def locked_organism?(_modification)
    false
  end

  def locked_program?(_modification_class)
    false
  end

  def section; end

  def self.filtered_sections(sections)
    sections
  end

  def self.filtered_programs(programs, modification_type)
    filter_collection_with_added(programs, modification_type)
  end

  def any_section?
    section.present?
  end

  def set_number
    self.number = build_number
  end

  def set_number_default
    self.number = number_pattern_filled
  end

  def build_number
    (number_sufix.zero? ? [number_base] : [number_base_with_sep, number_sufix]).join
  end

  def program; end

  def number_pattern
    '#'
  end

  def number_pattern_filled(section = '0', territory = '0', program = '0')
    format(number_pattern, section, territory, program)
  end

  def number_base
    number_pattern_filled((section&.ref).to_i, (territory&.iso&.gsub('ES-', '') || ''), program&.visible_ref || 0)
  end

  def number_sufix_sep
    '_'
  end

  def number_base_with_sep
    [number_base, number_sufix_sep].join
  end

  def number_sufix
    sufixes = existing_number_sufixes
    ((0..sufixes.max&.next.to_i).to_a - sufixes).min
  end

  def existing_number_sufixes
    budget.amendments
          .by_number_base(number_base, number_base_with_sep, id)
          .pluck(:number)
          .map { |n| n.gsub(number_base_with_sep, '').to_i }
  end
end

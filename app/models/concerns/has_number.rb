# frozen_string_literal: true

module HasNumber
  extend ActiveSupport::Concern

  included do
    validates :number, :explanation, presence: true
    validates :number, uniqueness: { scope: :budget }
    before_validation :set_number_default, unless: :persisted?
    before_validation :set_number, if: :number_criterias_changed?
    scope :by_number_base, lambda { |number_base, number_base_with_sep, id|
                             id_operator = id.nil? ? 'IS NOT' : '!='
                             where("(number = ? OR number LIKE ?) AND id #{id_operator} ?",
                                   number_base, "#{number_base_with_sep}%", id)
                           }
  end

  private

  def build_number
    (number_sufix.zero? ? [number_base] : [number_base_with_sep, number_sufix]).join
  end

  def existing_number_sufixes
    budget.amendments
          .by_number_base(number_base, number_base_with_sep, id)
          .pluck(:number)
          .map { |n| n.gsub(number_base_with_sep, '').to_i }
  end

  def number_criterias_changed?
    (changes.keys & self.class::NUMBER_REBUILD_FIELDS).any?
  end

  def number_base
    number_pattern_filled((section&.ref).to_i, (territory&.iso&.gsub('ES-', '') || 'empty_territory'), program&.visible_ref || 0)
  end

  def number_base_with_sep
    [number_base, number_sufix_sep].join
  end

  def number_pattern
    '#'
  end

  def number_pattern_filled(section = '0', territory = '0', program = '0')
    format(number_pattern, section, territory, program)
  end

  def number_sufix
    sufixes = existing_number_sufixes
    ((0..sufixes.max&.next.to_i).to_a - sufixes).min
  end

  def number_sufix_sep
    '.'
  end

  def set_number
    self.number = build_number
  end

  def set_number_default
    self.number = number_pattern_filled
  end
end

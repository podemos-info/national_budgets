# frozen_string_literal: true

class Amendment < ApplicationRecord
  include HasType
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :territory, optional: false

  validates :number, :explanation, presence: true
  validates :number, uniqueness: { scope: :budget }
  validate :type_locked, on: :update, if: :locked_type?

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
end

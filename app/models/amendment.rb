# frozen_string_literal: true

class Amendment < ApplicationRecord
  include HasDocx
  include HasNumber
  include HasType
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :territory, optional: false
  validate :type_locked, on: :update, if: :locked_type?

  def allow_articulated?; end

  def allow_modifications?; end

  def allow_organism_budget?; end

  def any_section?
    section.present?
  end

  def any_articulated?
    false
  end

  def any_modifications?; end

  def completed?; end

  def display_amount
    0
  end

  def locked_type?
    persisted? && (any_articulated? || any_modifications?)
  end

  def locked_organism?(_modification)
    false
  end

  def locked_program?(_modification_class)
    false
  end

  def program; end

  def section; end

  def total_amount
    0
  end

  def self.filtered_programs(programs, modification_type)
    filter_collection_with_added(programs, modification_type)
  end

  def self.filtered_sections(sections)
    sections
  end
end

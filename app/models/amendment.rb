# frozen_string_literal: true

class Amendment < ApplicationRecord
  include HasType
  belongs_to :user, optional: false
  belongs_to :budget, optional: false

  validates :number, :explanation, presence: true
  validate :type_locked, on: :update, if: :locked_type?

  def any_modifications?; end

  def allow_modifications?; end

  def any_articulated?; end

  def allow_articulated?; end

  def completed?; end

  def locked_type?
    persisted? && (any_articulated? || any_modifications?)
  end

  def section; end

  def any_section?
    section.present?
  end
end

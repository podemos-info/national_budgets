# frozen_string_literal: true

module HasModificationProgram
  extend ActiveSupport::Concern

  included do
    delegate :program, to: :first_addition, allow_nil: true
  end

  def first_addition
    additions.first
  end

  def locked_program?(modification_class, modification = nil)
    Modifications::Addition.new.is_a?(modification_class) &&
      additions.where.not(id: modification&.id).count.positive?
  end
end

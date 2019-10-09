# frozen_string_literal: true

module HasModificationSection
  extend ActiveSupport::Concern

  included do
    delegate :section, to: :first_modification, allow_nil: true
  end

  def first_modification
    modifications&.first
  end
end

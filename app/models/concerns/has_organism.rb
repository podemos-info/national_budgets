# frozen_string_literal: true

module HasOrganism
  extend ActiveSupport::Concern

  included do
    after_initialize :initialize_organism
  end

  private

  def initialize_organism
    self.organism ||= amendment&.organism if new_record?
  end
end

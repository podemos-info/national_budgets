# frozen_string_literal: true

class Subconcept < ApplicationRecord
  include HasFullTitle

  belongs_to :concept, optional: false
  delegate :budget, to: :concept, allow_nil: false
end

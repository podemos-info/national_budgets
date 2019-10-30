# frozen_string_literal: true

class Subconcept < ApplicationRecord
  include HasFullTitle

  belongs_to :concept, optional: false
end

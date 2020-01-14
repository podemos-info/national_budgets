# frozen_string_literal: true

class Article < ApplicationRecord
  include HasFullTitle

  belongs_to :chapter, optional: false
  has_many :concepts, dependent: :destroy
  has_many :subconcepts, through: :concepts
  delegate :budget, to: :chapter, allow_nil: false
end

class Article < ApplicationRecord
  belongs_to :chapter
  has_many :concepts
  has_many :subconcepts, through: :concepts

  include HasFullTitle
end

class Article < ApplicationRecord
  include HasFullTitle

  belongs_to :chapter
  has_many :concepts
  has_many :subconcepts, through: :concepts
end

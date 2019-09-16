class Concept < ApplicationRecord
  include HasFullTitle

  belongs_to :article
  has_many :subconcepts
end

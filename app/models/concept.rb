class Concept < ApplicationRecord
  belongs_to :article
  has_many :subconcepts
end
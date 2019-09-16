class Subconcept < ApplicationRecord
  include HasFullTitle

  belongs_to :concept
end

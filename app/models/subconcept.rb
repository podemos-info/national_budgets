class Subconcept < ApplicationRecord
  belongs_to :concept

  include HasFullTitle
end

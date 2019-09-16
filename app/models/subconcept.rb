class Subconcept < ApplicationRecord
  belongs_to :concept

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

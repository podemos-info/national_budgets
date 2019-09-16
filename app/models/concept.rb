class Concept < ApplicationRecord
  belongs_to :article
  has_many :subconcepts

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

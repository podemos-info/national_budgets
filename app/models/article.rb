class Article < ApplicationRecord
  belongs_to :chapter
  has_many :concepts
  has_many :subconcepts, through: :concepts

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

class Chapter < ApplicationRecord
  belongs_to :budget
  has_many :articles
  has_many :concepts, through: :articles

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

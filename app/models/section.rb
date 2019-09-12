class Section < ApplicationRecord
  belongs_to :budget
  has_many :services
  has_many :programs
  has_many :organisms

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

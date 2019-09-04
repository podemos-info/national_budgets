class Section < ApplicationRecord
  belongs_to :budget
  has_many :service
end

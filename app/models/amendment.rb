class Amendment < ApplicationRecord
  belongs_to :user
  belongs_to :budget
  has_many :articulateds
end

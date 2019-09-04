class Service < ApplicationRecord
  belongs_to :budget
  belongs_to :section
end

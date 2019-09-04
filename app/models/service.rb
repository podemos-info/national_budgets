class Service < ApplicationRecord
  belongs_to :budget, through: :section
  belongs_to :section
end

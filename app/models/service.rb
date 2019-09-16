class Service < ApplicationRecord
  include HasFullTitle

  belongs_to :section
end

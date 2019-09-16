class Service < ApplicationRecord
  belongs_to :section

  include HasFullTitle
end

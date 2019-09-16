class Program < ApplicationRecord
  include HasFullTitle

  belongs_to :section, optional: true
  belongs_to :organism, optional: true
end

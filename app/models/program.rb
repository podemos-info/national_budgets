class Program < ApplicationRecord
  belongs_to :section, optional: true
  belongs_to :organism, optional: true
end

class Program < ApplicationRecord
  belongs_to :section, optional: true
  belongs_to :organism, optional: true

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

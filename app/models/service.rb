class Service < ApplicationRecord
  belongs_to :section

  def full_title
    ref.to_s.rjust(2, '0') + '. ' + title
  end
end

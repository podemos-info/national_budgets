# frozen_string_literal: true

class Articulated < ApplicationRecord
  belongs_to :amendment
  belongs_to :section

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end
end

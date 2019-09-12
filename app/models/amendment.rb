class Amendment < ApplicationRecord
  belongs_to :user
  belongs_to :budget

  def allow_articulateds?
    false
  end

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end
end

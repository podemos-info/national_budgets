# frozen_string_literal: true

class Amendment < ApplicationRecord
  belongs_to :user
  belongs_to :budget

  def modifications?
    false
  end

  def allow_modifications?
    false
  end

  def allow_articulateds?
    false
  end

  def type_name
    self.class.to_s.demodulize.underscore.humanize
  end
end

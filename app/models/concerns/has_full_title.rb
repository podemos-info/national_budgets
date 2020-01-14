# frozen_string_literal: true

module HasFullTitle
  extend ActiveSupport::Concern

  def full_title
    [ref ? [visible_ref, '. '].join : '', title].join
  end

  def visible_ref
    ref.to_s.rjust(2, '0')
  end
end

# frozen_string_literal: true

module HasFullTitle
  extend ActiveSupport::Concern

  def full_title
    [ref ? [ref.to_s.rjust(2, '0'), '. '].join : '', title].join
  end
end

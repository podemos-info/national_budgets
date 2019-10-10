# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'success', error: 'danger', alert: 'warning', notice: 'info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def truncate_with_title(text_to_truncate, length = 160)
    return if text_to_truncate.blank?

    safe_join([content_tag(:span, truncate(text_to_truncate, length: length), title: text_to_truncate.gsub("'", "\\'"))])
  end
end

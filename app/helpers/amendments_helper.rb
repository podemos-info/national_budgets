module AmendmentsHelper
  def browse_title(object, path)
    "#{object.class.to_s}: #{link_to(object.full_title, path)}<br>".html_safe
  end

  def browse_link(object, path)
    "#{link_to(object.full_title, path)}<br>".html_safe
  end
end

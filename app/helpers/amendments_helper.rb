# frozen_string_literal: true

module AmendmentsHelper
  def collection_title(collection)
    content_tag(:b, 'Elige ' + collection.first.class.model_name.human.downcase) + ':<br>'.html_safe if collection.size.positive?
  end

  def browse_title(object)
    content_tag(:b, object.class.model_name.human) + ": #{object.full_title}" + '<br>'.html_safe
  end

  def browse_link(object, path)
    link_to(object.full_title, path) + '<br>'.html_safe
  end

  def reset_link(path)
    link_to('&#x2716;'.html_safe, path, class: 'text-danger', style: 'text-decoration: none')
  end
end

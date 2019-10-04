# frozen_string_literal: true

module AmendmentsHelper
  def collection_title(collection)
    return t('helpers.views.empty_collection', model: collection.model_name.human(count: 0).downcase) unless collection.size.positive?

    content_tag(:b, t('helpers.views.choose_model', model: collection.model_name.human.downcase)) + ':<br>'.html_safe
  end

  def browse_title(object)
    content_tag(:b, object.class.model_name.human) + ": #{object.full_title}" + '<br>'.html_safe
  end

  def browse_link(object, path)
    link_to(object.full_title, path) + '<br>'.html_safe
  end

  def reset_link(path)
    link_to(fa_icon('times-circle'), path, class: 'text-danger', style: 'text-decoration: none')
  end

  def amendment_section_link(amendment)
    '<b>'.html_safe + Section.model_name.human + ':</b> '.html_safe + amendment.section&.full_title if amendment.section?
  end
end

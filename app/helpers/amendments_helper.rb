# frozen_string_literal: true

module AmendmentsHelper
  def collection_title(collection)
    return t('helpers.views.empty_collection', model: collection.model_name.human(count: 0).downcase) if collection.empty?

    safe_join([content_tag(:b, t('helpers.views.choose_model', model: collection.model_name.human.downcase)), tag(:br)])
  end

  def browse_title(object)
    safe_join([content_tag(:b, object.class.model_name.human + ': '), content_tag(:span, object.full_title), tag(:br)])
  end

  def browse_link(object, path)
    safe_join([link_to(object.full_title, path), tag(:br)])
  end

  def reset_link(path)
    link_to(fa_icon('times-circle'), path, class: 'text-danger', style: 'text-decoration: none')
  end

  def amendment_section_label(amendment)
    return '' unless amendment.any_section?

    safe_join([content_tag(:b, Section.model_name.human + ': '), content_tag(:span, amendment.section.full_title)])
  end
end

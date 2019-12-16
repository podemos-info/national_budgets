# frozen_string_literal: true

module AmendmentsHelper
  def collection_title(collection)
    return t('helpers.views.empty_collection', model: collection.model_name.human(count: 0).downcase) if collection.empty?

    safe_join([content_tag(:b, t('helpers.views.choose_model', model: collection.model_name.human.downcase)), tag(:br)])
  end

  def browse_title(object, is_added = false)
    label = [object.class.model_name.human, (is_added ? ' nuevo' : ''), ': '].join
    safe_join([content_tag(:b, label), content_tag(:span, object.full_title)])
  end

  def browse_title_with_edit(object)
    return browse_title(object, object.added) unless object.added

    safe_join [browse_title(object, object.added), edit_field_title_input(object), edit_link(object)]
  end

  def browse_link(object, path)
    safe_join([link_to(object.full_title, path, class: 'browse_link'), tag(:br)])
  end

  def reset_link(path, locked = false)
    color_class = 'text-danger'
    style = ''
    title = 'Desmarcar'
    if locked
      path = 'javascript:void(0)'
      color_class = 'text-muted'
      style = 'cursor: not-allowed'
      title = 'Bloqueado'
    end
    link_to(fa_icon('times-circle'), path, class: ['browse_link', color_class], style: style, title: title)
  end

  def edit_link(object)
    link_to(fa_icon('pencil'), 'javascript: void(0)', class: 'edit_link text-dark pl-2 pt-2', object_id: object.id, title: 'Editar')
  end

  def new_field_title_input(field)
    return unless amendment.allowed_new_field_for?(modification_type, field)

    text_field_tag 'new',
                   '',
                   class: %w[form-control mt-2],
                   placeholder: t('helpers.views.new_model_title', model: field.to_s.camelcase.constantize.model_name.human.downcase),
                   model: field.to_s
  end

  def edit_field_title_input(object)
    return unless object.added

    text_field_tag 'edit',
                   object.title,
                   class: "edit-#{object.id}",
                   placeholder: 'Nuevo título',
                   model: object.class.name.underscore,
                   style: 'display: none; line-height: 1rem; border: none; border-bottom: 1px solid black;\
                           box-shadow: none !important; width: 60%'
  end

  def amendment_section_label(amendment)
    return '' unless amendment.any_section?

    safe_join([content_tag(:b, Section.model_name.human + ': '), content_tag(:span, amendment.section.full_title)])
  end

  def added_badge_for(object)
    return unless object.added

    content_tag(:span, 'Nuevo', class: %w[badge badge-secondary], style: 'font-size: .6rem; text-transform: uppercase')
  end
end

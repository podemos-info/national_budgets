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

  def browse_title_editable(object)
    return browse_title(object, object.added) unless object.added

    content_tag :div, build_edit_object_form(object), class: 'object_form'
  end

  def new_object_form(field)
    return unless amendment.allowed_new_field_for?(modification_type, field)

    content_tag :div, build_new_object_form(field), class: 'object_form new form-control'
  end

  def build_new_object_form(field)
    placeholder = t('helpers.views.new_model_title', model: field.to_s.camelcase.constantize.model_name.human.downcase)
    safe_join [object_title_input('', placeholder),
               object_hidden_input(:model, field)]
  end

  def build_edit_object_form(object)
    safe_join [browse_title(object, object.added),
               object_title_input(object.title, 'Nuevo título'),
               object_hidden_input(:model, object.class.name.underscore),
               edit_links(object)]
  end

  def browse_link(object, path)
    safe_join([link_to(object.full_title, path), tag(:br)])
  end

  def reset_link(model, path, locked = false)
    color_class = 'text-danger'
    style = ''
    title = 'Desmarcar'
    if locked
      path = 'javascript:void(0)'
      color_class = 'text-muted'
      style = 'cursor: not-allowed'
      title = 'Bloqueado'
    end
    link_to(fa_icon('times-circle'), path, class: "reset_link #{model} #{color_class}", style: style, title: title)
  end

  def edit_links(object)
    safe_join([link_to(fa_icon('pencil'),
                       'javascript:void(0)',
                       class: "#{object.model_name.name.underscore} edit_link edit text-dark pl-2 pt-2",
                       object_id: object.id,
                       title: 'Editar'),
               link_to(fa_icon('undo'),
                       'void(0)',
                       class: "#{object.model_name.name.underscore} edit_link cancel text-dark pl-2 pt-2",
                       object_id: object.id,
                       title: 'Cancelar edición')])
  end

  def object_title_input(value, placeholder)
    text_field_tag 'object[title]', value, placeholder: placeholder
  end

  def object_hidden_input(field, value)
    hidden_field(:object, field, value: value)
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

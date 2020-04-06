# frozen_string_literal: true

ActiveAdmin.register Amendment do
  belongs_to :budget, optional: true

  index do
    selectable_column
    column :number do |amendment|
      link_to(amendment.number, [:admin, amendment.becomes(Amendment)])
    end
    column :type, &:type_name
    column t('helpers.label.amendment.balance') do |amendment|
      number_to_currency amendment.display_amount if amendment.allow_modifications?
    end
    column t('helpers.label.amendment.total_amount') do |amendment|
      number_to_currency amendment.total_amount if amendment.allow_modifications?
    end
    column model_name(:modification) do |amendment|
      if amendment.allow_modifications?
        link_to(model_total(amendment.modifications), [:admin, amendment.becomes(Amendment), :modifications])
      end
    end
    column model_name(:articulated, 1), &:any_articulated?
    column t('helpers.label.amendment.status') do |amendment|
      status_tag(amendment.completed?, label: t('helpers.action.completed'))
    end
    actions
  end

  show do
    attributes_table do
      row :number
      row :type, &:type_name
      row t('helpers.label.amendment.balance') do |amendment|
        number_to_currency amendment.display_amount
      end
      row t('helpers.label.amendment.total_amount') do |amendment|
        number_to_currency amendment.total_amount
      end
      row model_name(:modifications) do |amendment|
        if amendment.allow_modifications?
          link_to(model_total(amendment.modifications), [:admin, amendment.becomes(Amendment), :modifications])
        end
      end
      row model_name(:articulated, 1), &:any_articulated?
      row :user
      row t('helpers.label.amendment.status') do |amendment|
        status_tag(amendment.completed?, label: t('helpers.action.completed'))
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user, as: :string, input_html: { readonly: true }
      f.input :number
      f.input :date
    end

    f.actions
  end
end

# frozen_string_literal: true

ActiveAdmin.register AmendmentsDocument do
  belongs_to :budget, optional: true

  permit_params :user_id, :budget_id, :section_id, :file_type

  index do
    selectable_column
    column :budget
    column :user
    column :section do |amendments_document|
      amendments_document.section || t('active_admin.scopes.all')
    end
    column :file_type
    column :file do |amendments_document|
      if amendments_document.file.attached?
        link_to File.basename(url_for(amendments_document.file)),
                rails_blob_path(amendments_document.file, disposition: 'attachment')
      else
        'Generando fichero'
      end
    end
    column :current_amendments do |amendments_document|
      model_total(amendments_document.amendments)
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :budget
      row :user
      row :section do |amendments_document|
        amendments_document.section || t('active_admin.scopes.all')
      end
      row :file_type
      row :file do |amendments_document|
        if amendments_document.file.attached?
          link_to File.basename(url_for(amendments_document.file)),
                  rails_blob_path(amendments_document.file, disposition: 'attachment')
        else
          'Generando fichero'
        end
      end
      row :current_amendments do |amendments_document|
        model_total(amendments_document.amendments)
      end
      row :created_at
      row :updated_at
    end
  end

  filter :budget
  filter :user
  filter :section
  filter :file_type, as: :select

  form do |f|
    f.inputs do
      f.input :user, as: :hidden
      f.input :user, as: :select, input_html: { disabled: true }
      f.input :budget,
              prompt: t('helpers.views.choose_model', model: Budget.model_name.human.downcase),
              collection: Budget.with_attached_docx_template
      f.input :section, include_blank: t('active_admin.scopes.all')
      f.input :file_type, as: :radio
    end

    f.actions
  end

  controller do
    def build_resource
      super.tap { |ret| ret.user = current_user unless ret.persisted? }
    end
  end
end

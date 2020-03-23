# frozen_string_literal: true

module HasDocx
  extend ActiveSupport::Concern

  included do
    has_one_attached :docx
    after_save :attach_docx, if: :needs_docx_regeneration?
  end

  def render_docx
    return unless budget.docx_template.attached?

    template = Sablon.template ActiveStorage::Blob.service.send(:path_for, budget.docx_template.key)
    context = { amendment: self }
    template.render_to_file(tmp_docx_path, context)
  end

  def last_updated_modification
    modifications.pluck(:updated_at).max if any_modifications?
  end

  def modifications_last_updated_related_object
    return unless any_modifications?

    modifications.map do |m|
      %i[section service program organism chapter article concept subconcept].map do |model|
        m.send(model)&.updated_at
      end.compact.max
    end.compact.max
  end

  def amendment_related_objects_changed?
    %i[budget section].each do |model|
      return true if send(model).present? && updated_at < send(model)&.updated_at
    end

    %i[last_updated_modification modifications_last_updated_related_object].each do |last_update_at|
      return true if send(last_update_at).present? && updated_at < send(last_update_at)
    end
    false
  end

  def needs_docx_regeneration?
    updated_at_previously_changed? || amendment_related_objects_changed?
  end

  def criterias_changed?
    updated_at_previously_changed?
  end

  def docx_filename
    "#{number}.docx"
  end

  def tmp_docx_path
    "#{Rails.root}/tmp/generated.#{docx_filename}"
  end

  def attach_docx
    docx.purge if docx.attached?
    return unless render_docx

    docx.attach io: File.open(tmp_docx_path),
                filename: docx_filename,
                content_type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    File.delete(tmp_docx_path)
  end
end

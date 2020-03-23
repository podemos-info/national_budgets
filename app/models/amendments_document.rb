# frozen_string_literal: true

class AmendmentsDocument < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :section, optional: true
  has_one_attached :file
  enum file_type: { 'docx' => 0 }
  validates :file_type, presence: true
  after_save :attach_amendments_document_job, if: :needs_amendments_document_regeneration?

  FILE_REGENERATION_FIELDS = %w[budget_id section_id file_type updated_at].freeze

  def amendments
    if section
      budget.amendments.where(id: (Modification.where(section: section) + Articulated.where(section: section)).pluck(:amendment_id).uniq)
    else
      budget.amendments
    end
  end

  def attach_amendments_document_job
    file.purge if file.attached?
    GenerateAmendmentsDocumentFileJob.perform_later self
  end

  def attach_file
    build_tmp_file
    file.attach io: File.open(tmp_file_path),
                filename: filename,
                content_type: 'application/zip, application/octet-stream'
    File.delete(tmp_file_path)
  end

  def set_amendments_hash
    self.amendments_hash = build_amendments_hash
  end

  def amendments_related_objects_changed?
    return true if updated_at < budget.updated_at

    %w[amendments amendments_articulateds amendments_articulateds_sections
       amendments_modifications amendments_modifications_related_objects].each do |model|
      return true if send("#{model}_max_updated_at") && updated_at < send("#{model}_max_updated_at")
    end
    false
  end

  def amendments_max_updated_at
    amendments.pluck(:updated_at).compact.max
  end

  def amendments_modifications_max_updated_at
    amendments.map { |a| a.modifications.pluck(:updated_at).max if a.any_modifications? }.compact.max
  end

  def amendments_modifications_related_objects_max_updated_at
    amendments.map do |a|
      next unless a.any_modifications?

      a.modifications.map do |m|
        %w[section service program organism chapter article concept subconcept].map do |model|
          m.send(model)&.updated_at
        end.compact.max
      end.compact.max
    end.compact.max
  end

  def amendments_articulateds_max_updated_at
    amendments.map { |a| a.articulated.updated_at if a.any_articulated? }.compact.max
  end

  def amendments_articulateds_sections_max_updated_at
    amendments.map { |a| a.articulated.section.updated_at if a.any_articulated? }.compact.max
  end

  def amendments_docxs
    amendments.map do |a|
      a.attach_docx unless a.docx.attached?
      a.docx
    end.compact
  end

  def needs_amendments_document_regeneration?
    criterias_changed? || amendments_related_objects_changed?
  end

  def criterias_changed?
    (saved_changes.keys & FILE_REGENERATION_FIELDS).any?
  end

  def filename
    @filename ||= [[Time.current.strftime('%Y%m%d%H%M%S'),
                    budget.title.parameterize,
                    section&.visible_ref].compact.join('_'),
                   amendments.size,
                   'zip'].join('.')
  end

  def tmp_file_path
    @tmp_file_path ||= "#{Rails.root}/tmp/generated.#{filename}"
  end

  def build_tmp_file
    Zip::File.open(tmp_file_path, Zip::File::CREATE) do |zipfile|
      amendments_docxs.each do |docx|
        zipfile.add(docx.filename.to_s, ActiveStorage::Blob.service.send(:path_for, docx.key))
      end
    end
  end
end

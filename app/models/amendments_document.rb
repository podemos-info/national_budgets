# frozen_string_literal: true

class AmendmentsDocument < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :section, optional: true
  has_one_attached :file
  enum file_type: { 'docx' => 0, 'xlsx' => 1 }

  validates :file_type, presence: true

  after_save :attach_amendments_document_job, if: :criterias_changed?

  def amendments_collection
    if section
      budget.amendments.where(id: (Modification.where(section: section) + Articulated.where(section: section)).pluck(:amendment_id).uniq)
    else
      budget.amendments
    end
  end

  def attach_amendments_document_job
    file.purge if file.attached?
    AttachAmendmentsDocumentJob.perform_later self
  end

  def attach_file
    File.open(tmp_file_path, 'w') { |f| f.write file_content }
    file.attach(io: File.open(tmp_file_path), filename: file_name, content_type: 'text/plain')
    File.delete(tmp_file_path)
  end

  def criterias_changed?
    (saved_changes.keys & %w[budget_id section_id file_type updated_at]).any?
  end

  def file_content
    ret = ''
    2000.times.each do
      amendments_collection.each do |amendment|
        ret += amendment.number + "\n"
      end
    end
    ret
  end

  def file_name
    @file_name ||= [[Time.current.strftime('%Y%m%d%H%M%S'),
                     budget.title,
                     section&.visible_ref].compact.join('_'),
                    amendments_collection.size,
                    file_type].join('.')
  end

  def tmp_file_path
    @tmp_file_path ||= "#{Rails.root}/tmp/uploaded.#{file_name}"
  end
end

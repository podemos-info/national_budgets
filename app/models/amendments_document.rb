# frozen_string_literal: true

class AmendmentsDocument < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :budget, optional: false
  belongs_to :section, optional: true
  has_one_attached :file
  enum file_type: { 'docx' => 0, 'xlsx' => 1 }

  validates :file_type, presence: true

  before_save :attach_file

  def amendments_collection
    if section
      budget.amendments.where(id: (Modification.where(section: section) + Articulated.where(section: section)).pluck(:amendment_id).uniq)
    else
      budget.amendments
    end
  end

  def attach_file
    file.purge
    File.open(tmp_file_path, 'w') { |f| f.write file_content }
    file.attach(io: File.open(tmp_file_path), filename: file_name, content_type: 'text/plain')
    File.delete(tmp_file_path)
  end

  def file_content
    amendments_collection.pluck(:number).join("\n")
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

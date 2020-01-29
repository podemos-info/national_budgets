# frozen_string_literal: true

class AttachAmendmentsDocumentJob < ApplicationJob
  queue_as :default

  def perform(*amendments_document)
    amendments_document.first.attach_file
  end
end

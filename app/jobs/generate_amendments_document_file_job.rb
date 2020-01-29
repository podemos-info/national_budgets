# frozen_string_literal: true

class GenerateAmendmentsDocumentFileJob < ApplicationJob
  queue_as :default

  def perform(*amendments_documents)
    amendments_documents.each(&:attach_file)
  end
end

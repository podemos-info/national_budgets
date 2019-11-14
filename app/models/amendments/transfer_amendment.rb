# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    include HasModifications
    include HasModificationSection
  end
end

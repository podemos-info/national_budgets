# frozen_string_literal: true

module Amendments
  class StandardAmendment < Amendment
    include HasModifications
    include HasModificationSection
  end
end

# frozen_string_literal: true

module Amendments
  class StandardAmendment < Amendment
    include HasModifications
    include HasModificationSection

    has_many :modifications, foreign_key: :amendment_id,
                             class_name: 'Modifications::StandardModification',
                             dependent: :destroy,
                             inverse_of: :amendment
  end
end

# frozen_string_literal: true

module Amendments
  class TransferAmendment < Amendment
    include HasModifications
    include HasModificationSection

    has_many :modifications, foreign_key: :amendment_id,
                             class_name: 'Modifications::TransferModification',
                             dependent: :destroy,
                             inverse_of: :amendment
  end
end

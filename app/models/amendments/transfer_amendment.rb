module Amendments
  class TransferAmendment < Amendment
    has_many :modifications, foreign_key: "amendment_id"

    def allow_modifications?
      true
    end
  end
end

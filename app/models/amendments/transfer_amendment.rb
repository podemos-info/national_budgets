module Amendments
  class TransferAmendment < Amendment
    def self.model_name
      Amendment.model_name
    end

    def type_name
      'Transferencia'
    end
  end
end

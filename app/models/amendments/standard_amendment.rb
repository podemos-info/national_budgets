module Amendments
  class StandardAmendment < Amendment
    def self.model_name
      Amendment.model_name
    end

    def type_name
      'Alta/baja'
    end
  end
end

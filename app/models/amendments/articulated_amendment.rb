module Amendments
  class ArticulatedAmendment < Amendment
    def self.model_name
      Amendment.model_name
    end

    def type_name
      'Al articulado'
    end
  end
end

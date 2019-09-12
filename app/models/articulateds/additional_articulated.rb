module Articulateds
  class AdditionalArticulated < Articulated
    def self.model_name
      Articulated.model_name
    end

    def type_name
      'Disposición adicional'
    end
  end
end

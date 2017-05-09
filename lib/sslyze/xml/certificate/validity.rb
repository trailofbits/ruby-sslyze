module SSLyze
  class XML
    class Certificate
      #
      # Represents the `<validity>` XML element.
      #
      class Validity < Struct.new(:not_after, :not_before)
      end
    end
  end
end

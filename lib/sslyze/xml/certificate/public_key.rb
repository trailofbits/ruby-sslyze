module SSLyze
  class XML
    class Certificate
      #
      # Represents the `<publicKey>` XML element.
      #
      class PublicKey < Struct.new(:modulus, :exponent)
      end
    end
  end
end

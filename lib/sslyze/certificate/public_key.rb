module SSLyze
  class Certificate
    #
    # Represents the `<publicKey>` XML element.
    #
    class PublicKey < Struct.new(:modulus, :exponent)
    end
  end
end

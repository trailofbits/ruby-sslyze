module SSLyze
  class Certificate
    class PublicKey < Struct.new(:modulus, :exponent)
    end
  end
end

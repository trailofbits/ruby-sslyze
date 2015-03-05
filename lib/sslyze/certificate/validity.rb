module SSLyze
  class Certificate
    class Validity < Struct.new(:not_after, :not_before)
    end
  end
end

module SSLyze
  module X509
    #
    # Wraps around an [OpenSSL::X509::Extension][1] object.
    #
    # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension
    #
    class Extension

      #
      # @param [OpenSSL::X509::Extension] ext
      #
      def initialize(ext)
        @ext = ext
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#critical%3F-instance_method
      #
      def critical?
        @ext.critical?
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#oid-instance_method
      #
      def oid
        @ext.oid
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#to_a-instance_method
      #
      def to_a
        @ext.to_a
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#to_der-instance_method
      #
      def to_der
        @ext.to_der
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#to_h-instance_method
      #
      def to_h
        @ext.to_h
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#to_s-instance_method
      #
      def to_s
        @ext.to_s
      end

      #
      # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension#value-instance_method
      #
      def value
        @ext.value
      end

    end
  end
end

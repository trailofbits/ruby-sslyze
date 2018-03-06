require 'delegate'

module SSLyze
  module X509
    #
    # Wrapper class around [OpenSSL::PKey] classes that provide {#algorithm} and
    # {#size} methods.
    #
    # [OpenSSL::PKey]: http://www.rubydoc.info/stdlib/openssl/OpenSSL/PKey
    #
    # @since 1.0.0
    #
    class PublicKey < SimpleDelegator

      #
      # The algorithm that generated the public key.
      #
      # @return [:rsa, :dsa, :dh, :ec]
      #
      def algorithm
        case __getobj__
        when OpenSSL::PKey::RSA then :rsa
        when OpenSSL::PKey::DSA then :dsa
        when OpenSSL::PKey::DH  then :dh
        when OpenSSL::PKey::EC  then :ec
        end
      end

      #
      # The size of the public key.
      #
      # @return [Integer]
      #   The number of bits in the public key.
      #
      # @raise [NotImplementedError]
      #   Determining key size for `OpenSSL::PKey::EC` public keys is currently
      #   not implemented.
      #
      def size
        pkey = __getobj__

        case pkey
        when OpenSSL::PKey::RSA then pkey.n.num_bits
        when OpenSSL::PKey::DSA then pkey.p.num_bits
        when OpenSSL::PKey::DH  then pkey.p.num_bits
        when OpenSSL::PKey::EC
          raise(NotImplementedError,"key size for #{pkey.inspect} not implemented")
        end
      end

    end
  end
end

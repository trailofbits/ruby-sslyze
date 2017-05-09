require 'sslyze/xml/certificate/public_key'

module SSLyze
  class XML
    class Certificate
      #
      # Represents the `<subjectPublicKeyInfo>` XML element.
      #
      class SubjectPublicKeyInfo

        #
        # Initializes the subject public key info.
        #
        # @param [Nokogiri::XML::Node] node
        #   The `<subjectPublicKeyInfo>` XML element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Public key info.
        #
        # @return [PublicKey]
        #
        def public_key
          @public_key ||= PublicKey.new(
            @node.at('publicKey/modulus').inner_text,
            @node.at('publicKey/exponent').inner_text.to_i
          )
        end

        #
        # Public key algorithm.
        #
        # @return [String]
        #
        def public_key_algorithm
          @public_key_algorithm ||= @node.at('publicKeyAlgorithm').inner_text
        end

        #
        # Public key size.
        #
        # @return [Integer]
        #   The key size in bits.
        #
        def public_key_size
          @public_key_size ||= @node.at('publicKeySize').inner_text.chomp(' bits').to_i
        end

      end
    end
  end
end

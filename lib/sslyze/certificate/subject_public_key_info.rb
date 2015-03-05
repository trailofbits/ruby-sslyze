require 'sslyze/certificate/public_key'

module SSLyze
  class Certificate
    class SubjectPublicKeyInfo

      def initialize(node)
        @node = node
      end

      def public_key
        @public_key ||= PublicKey.new(
          @node.at('publicKey/modulus').inner_text,
          @node.at('publicKey/exponent').inner_text.to_i
        )
      end

      def public_key_algorithm
        @public_key_algorithm ||= @node.at('publicKeyAlgorithm').inner_text
      end

      def public_key_size
        @public_key_size ||= @node.at('publicKeySize').inner_text.chomp(' bits').to_i
      end

    end
  end
end

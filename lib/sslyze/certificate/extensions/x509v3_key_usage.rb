require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      #
      # Represents the `<X509v3KeyUsage>` XML element.
      #
      class X509v3KeyUsage < Extension

        #
        # Key encipherment.
        #
        # @return [String]
        #
        def key_encipherment
          @key_encipherment ||= @node.at('KeyEncipherment').inner_text
        end

        #
        # Digital signature.
        #
        # @return [String]
        #
        def digital_signature
          @digital_signature ||= @node.at('DigitalSignature').inner_text
        end

        #
        # CRL Sign.
        #
        # @return [String]
        #
        def crl_sign
          @crl_sign ||= @node.at('CRLSign').inner_text
        end

        #
        # Certificate sign.
        #
        # @return [String]
        #
        def certificate_sign
          @certificate_sign ||= @node.at('CertificateSign').inner_text
        end

      end
    end
  end
end

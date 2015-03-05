require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      class X509v3KeyUsage < Extension

        def key_encipherment
          @key_encipherment ||= @node.at('KeyEncipherment').inner_text
        end

        def digital_signature
          @digital_signature ||= @node.at('DigitalSignature').inner_text
        end

        def crl_sign
          @crl_sign ||= @node.at('CRLSign').inner_text
        end

        def certificate_sign
          @certificate_sign ||= @node.at('CertificateSign').inner_text
        end

      end
    end
  end
end

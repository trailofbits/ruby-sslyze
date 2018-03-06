require 'sslyze/xml/plugin'
require 'sslyze/xml/certinfo/has_certificates'

module SSLyze
  class XML
    class Certinfo < Plugin
      class CertificateValidation
        #
        # Represents the `<verifiedCertificateChain>` XML element.
        #
        # @since 1.0.0
        #
        class VerifiedCertificateChain

          include Types
          include HasCertificates

          #
          # Initializes the {VerifiedCertificateChain} object.
          #
          # @param [Nokogiri::XML::Element] node
          #   The `<verifiedCertificateChain>` XML element.
          #
          def initialize(node)
            @node = node
          end

          #
          # Parses the `hasSha1SignedCertificate` XML attribute.
          #
          # @return [Boolean]
          #
          def has_sha1_signed_certificate?
            Boolean[@node['hasSha1SignedCertificate']]
          end

        end
      end
    end
  end
end

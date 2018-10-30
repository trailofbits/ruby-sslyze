require 'sslyze/xml/plugin'
require 'sslyze/xml/certinfo/received_certificate_chain'
require 'sslyze/xml/certinfo/certificate_validation'
require 'sslyze/xml/certinfo/certificate_validation/verified_certificate_chain'
require 'sslyze/xml/certinfo/ocsp_stapling'

module SSLyze
  class XML
    #
    # Represents the `<certinfo>` XML element.
    #
    # @since 1.0.0
    #
    class Certinfo < Plugin

      #
      # The received certificate chain.
      #
      # @return [ReceivedCertificateChain]
      #
      # @raise [PluginException]
      #
      def received_certificate_chain
        @received_certificate_chain ||= exception! do
          ReceivedCertificateChain.new(
            @node.at_xpath('receivedCertificateChain')
          )
        end
      end

      alias received_chain received_certificate_chain

      #
      # Certificate validation information.
      #
      # @return [CertificateValidation]
      #
      # @raise [PluginException]
      #
      def certificate_validation
        @certificate_validation ||= exception! do
          CertificateValidation.new(
            @node.at_xpath('certificateValidation')
          )
        end
      end

      alias validation certificate_validation

      #
      # The verified certificate chain.
      #
      # @return [VerifiedCertificateChain, nil]
      #
      # @raise [PluginException]
      #
      def verified_certificate_chain
        @verified_certificate_chain ||= exception! do
          if (element = @node.at_xpath('certificateValidation/verifiedCertificateChain'))
            CertificateValidation::VerifiedCertificateChain.new(element)

          end
        end
      end

      alias verified_chain verified_certificate_chain

      #
      # OCSP Stapling.
      #
      # @return [OCSPStapling]
      #
      # @raise [PluginException]
      #
      def ocsp_stapling
        @ocsp_stapling ||= exception! do
          OCSPStapling.new(@node.at_xpath('ocspStapling'))
        end
      end

    end
  end
end

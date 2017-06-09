require 'sslyze/xml/plugin'
require 'sslyze/xml/certinfo/received_certificate_chain'
require 'sslyze/xml/certinfo/certificate_validation'
require 'sslyze/xml/certinfo/ocsp_stapling'

module SSLyze
  class XML
    #
    # Represents the `<certinfo />` XML element.
    #
    # @since 1.0.0
    #
    class Certinfo < Plugin

      #
      # The received certificate chain.
      #
      # @return [ReceivedCertificateChain]
      #
      def received_certificate_chain
        @received_certificate_chain ||= ReceivedCertificateChain.new(
          @node.at_xpath('receivedCertificateChain')
        )
      end

      alias received_chain received_certificate_chain

      #
      # @return [CertificateValidation]
      #
      def certificate_validation
        @certificate_validation ||= CertificateValidation.new(
          @node.at_xpath('certificateValidation')
        )
      end

      alias validation certificate_validation

      #
      # The verified certificate chain.
      #
      # @return [VerifiedCertificateChain, nil]
      #
      def verified_certificate_chain
        @verified_certificate_chain ||= if (element = @node.at_xpath('certificateValidation/pathValidation/verifiedCertificateChain'))
                                          CertificateValidation::PathValidation::VerifiedCertificateChain.new(element)
                                          
                                        end
      end

      alias verified_chain verified_certificate_chain

      #
      # @return [OCSPStapling]
      #
      def ocsp_stapling
        @ocsp_stapling ||= OCSPStapling.new(@node.at_xpath('ocspStapling'))
      end

    end
  end
end

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
      # @return [ReceivedCertificateChain]
      #
      def received_certificate_chain
        @received_certificate_chain ||= ReceivedCertificateChain.new(@node.at('receivedCertificateChain'))
      end

      alias certificate_chain received_certificate_chain
      alias chain received_certificate_chain

      #
      # @return [CertificateValidation]
      #
      def certificate_validation
        @certificate_validation ||= CertificateValidation.new(@node.at('certificateValidation'))
      end

      alias validation certificate_validation

      #
      # @return [OCSPStapling]
      #
      def ocsp_stapling
        @ocsp_stapling ||= OCSPStapling.new(@node.at('ocspStapling'))
      end

    end
  end
end

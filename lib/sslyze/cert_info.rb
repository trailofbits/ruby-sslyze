require 'sslyze/certificate_chain'
require 'sslyze/certificate_validation'
require 'sslyze/ocsp_response'

module SSLyze
  #
  # Represents the `<certinfo>` element.
  #
  class CertInfo

    #
    # Initializes the cert info.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<certinfo>` element.
    #
    def initialize(node)
      @node = node
    end

    #
    # Certificate chain.
    #
    # @return [CertificateChain, nil]
    #
    def chain
      @chain ||= if (cert_chain = @node.at('certificateChain'))
                   CertificateChain.new(cert_chain)
                 end
    end

    #
    # Certificate validation information.
    #
    # @return [CertificateValidation, nil]
    #
    def validation
      @validation ||= if (node = @node.at('certificateValidation'))
                        CertificateValidation.new(node)
                      end
    end

    #
    # OCSP response stapling information.
    #
    # @return [OCSPResponse, nil]
    #
    def ocsp_response
      @ocsp_response ||= if (ocsp_response = @node.at('ocspStapling/ocspResponse'))
                           OCSPResponse.new(ocsp_response)
                         end
    end

    alias ocsp_stapling ocsp_response

  end
end

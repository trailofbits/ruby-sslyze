require 'sslyze/certificate_chain'
require 'sslyze/certificate_validation'

module SSLyze
  class CertInfo

    def initialize(node)
      @node = node
    end

    def chain
      @chain ||= if (cert_chain = @node.at('certificateChain'))
                   CertificateChain.new(cert_chain)
                 end
    end

    def validation
      @validation ||= CertificateValidation.new(@node.at('certificateValidation'))
    end

    def ocsp_stapling
      @ocsp_stapling ||= @node.at('ocspStapling/@error').value
    end

  end
end

require 'sslyze/certificate_chain'
require 'sslyze/certificate_validation'

module SSLyze
  class CertInfo

    def initialize(node)
      @node = node
    end

    def chain
      @chain ||= CertificateChain.new(@node.at('certificateChain'))
    end

    def validation
      @validation ||= CertificateValidation.new(@node.at('certificateValidation'))
    end

    def ocsp_stapling
      @ocsp_stapling ||= @node.at('ocspStapling/@error').value
    end

  end
end

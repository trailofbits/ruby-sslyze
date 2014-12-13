require 'sslyze/certificate'
require 'sslyze/certificate_validation'

module SSLyze
  class CertInfo

    def chain
      @chain ||= @node.search('certificateChain/certificate').map do |cert|
        Certificate.new(cert)
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

require 'sslyze/certificate/subject_public_key_info'
require 'sslyze/certificate/extensions'
require 'sslyze/certificate/subject'
require 'sslyze/certificate/validity'
require 'sslyze/certificate/issuer'

require 'date'

module SSLyze
  class Certificate

    def initialize(node)
      @node = node
    end

    def position
      @position ||= @node['position'].to_sym
    end

    def sha1_fingerprint
      @sha1_fingerprint ||= @node['sha1Fingerprint']
    end

    def as_pem
      @as_pem ||= @node.at('asPEM').inner_text
    end

    def subject_public_key_info
      @subject_public_key_info ||= SubjectPublicKeyInfo.new(
        @node.at('subjectPublicKeyInfo')
      )
    end

    def version
      @version ||= @node.at('version').inner_text.to_i
    end

    def extensions
      @extensions ||= Extensions.new(@node.at('extensions'))
    end

    def signature_value
      @signature_value ||= @node.at('signatureValue').inner_text
    end

    def signature_algorithm
      @signature_algorithm ||= @node.at('signatureAlgorithm').inner_text
    end

    def serial_number
      @serial_number ||= @node.at('serialNumber').inner_text
    end

    def subject
      @subject ||= Subject.new(@node.at('subject'))
    end

    def validity
      @validity ||= Validity.new(
        Date.parse(@node.at('validity/notAfter').inner_text),
        Date.parse(@node.at('validity/notBefore').inner_text)
      )
    end

    def issuer
      @issuer ||= Issuer.new(@node.at('issuer'))
    end

  end
end

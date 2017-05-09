require 'sslyze/xml/certificate/subject_public_key_info'
require 'sslyze/xml/certificate/extensions'
require 'sslyze/xml/certificate/subject'
require 'sslyze/xml/certificate/validity'
require 'sslyze/xml/certificate/issuer'

require 'date'

module SSLyze
  class XML
    #
    # Represents the `<certificate>` XML element.
    #
    class Certificate

      #
      # Initializes the certificate.
      #
      # @param [Nokogiri::XML::Node] node
      #   The `<certificate>` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The position of the certificate within the cert chain.
      #
      # @return [:leaf, :intermediate]
      #
      def position
        @position ||= @node['position'].to_sym
      end

      #
      # The SHA1 fingerprint of the cert.
      #
      # @return [String]
      #
      def sha1_fingerprint
        @sha1_fingerprint ||= @node['sha1Fingerprint']
      end

      #
      # The AS PEM information.
      #
      # @return [String]
      #
      def as_pem
        @as_pem ||= @node.at('asPEM').inner_text
      end

      #
      # The subject public key information.
      #
      # @return [SubjectPublicKeyInfo]
      #
      def subject_public_key_info
        @subject_public_key_info ||= SubjectPublicKeyInfo.new(
          @node.at('subjectPublicKeyInfo')
        )
      end

      #
      # The certificate SSL version.
      #
      # @return [Integer]
      #
      def version
        @version ||= @node.at('version').inner_text.to_i
      end

      #
      # The SSL extensions.
      #
      # @return [Extensions]
      #
      def extensions
        @extensions ||= Extensions.new(@node.at('extensions'))
      end

      #
      # The certificate signature.
      #
      # @return [String]
      #
      def signature_value
        @signature_value ||= @node.at('signatureValue').inner_text
      end

      #
      # The certificate signature algorithm.
      #
      # @return [String]
      #
      def signature_algorithm
        @signature_algorithm ||= @node.at('signatureAlgorithm').inner_text
      end

      #
      # The certificate serial number.
      #
      # @return [String]
      #
      def serial_number
        @serial_number ||= @node.at('serialNumber').inner_text
      end

      #
      # The certificate subject information.
      #
      # @return [Subject]
      #
      def subject
        @subject ||= Subject.new(@node.at('subject'))
      end

      #
      # The certificate validity.
      #
      # @return [Validity]
      #
      def validity
        @validity ||= Validity.new(
          Date.parse(@node.at('validity/notAfter').inner_text),
          Date.parse(@node.at('validity/notBefore').inner_text)
        )
      end

      #
      # The certificate issuer.
      #
      # @return [Issuer]
      #
      def issuer
        @issuer ||= Issuer.new(@node.at('issuer'))
      end

    end
  end
end

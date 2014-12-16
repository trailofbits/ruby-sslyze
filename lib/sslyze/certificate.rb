require 'date'

module SSLyze
  class Certificate

    class PublicKey < Struct.new(:modulus, :exponent)
    end

    class SubjectPublicKeyInfo

      def initialize(node)
        @node = node
      end

      def public_key
        @public_key ||= PublicKey.new(
          @node.at('publicKey/modulus').value,
          @node.at('publicKey/exponent').value.to_i
        )
      end

      def public_key_algorithm
        @public_key_algorithm ||= @node.at('publicKeyAlgorithm').value
      end

      def public_key_size
        @public_key_size ||= @node.at('publicKeySize').value.chomp(' bits').to_i
      end

    end

    class Subject

      def initialize(node)
        @node = node
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').value
      end

      def organization_name
        @organization_name ||= @node.at('organizationalName').value
      end

      def business_category
        @business_category ||= @node.at('businessCategory').value
      end

      def serial_number
        @serial_number ||= @node.at('serialNumber').value.to_i
      end

      def common_name
        @common_name ||= @node.at('commonName').value
      end

      def state_or_province_name
        @state_or_province_name ||= @node.at('stateOrProvinceName').value
      end

      def country_name
        @country_name ||= @node.at('countryName').value
      end

      def street_address
        @street_address ||= @node.at('streetAddress').value
      end

      # TODO: oid-1.3.6.1.4.1.311.60.2.1.2
      # TODO: oid-1.3.6.1.4.1.311.60.2.1.3

      def locality_name
        @locality_name ||= @node.at('localityName').value
      end

      def postal_code
        @postal_code ||= @node.at('postalCode').value
      end

    end

    class Validity < Struct.new(:not_after, :not_before)
    end

    class Issuer

      def initialize(node)
        @node = node
      end

      def country_name
        @country_name || @node.at('countryName').value
      end

      def common_name
        @common_name ||= @node.at('commonName').value
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').value
      end

      def organization_name
        @organization_name ||= @node.at('organizationName').value
      end

    end

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
      @as_pem ||= @node.at('asPEM').value
    end

    def subject_public_key_info
      @subject_public_key_info ||= SubjectPublicKeyInfo.new(
        @node.at('subjectPublicKeyInfo')
      )
    end

    def version
      @version ||= @node.at('version').value.to_i
    end

    def extensions
    end

    def signature_value
      @signature_value ||= @node.at('signatureValue').value
    end

    def signature_algorithm
      @signature_algorithm ||= @node.at('signatureAlgorithm').value
    end

    def serial_number
      @serial_number ||= @node.at('serialNumber').value
    end

    def subject
      @subject ||= Subject.new(@node.at('subject'))
    end

    def validity
      @validity ||= Validity.new(
        Date.parse(@node.at('validity/notAfter').value),
        Date.parse(@node.at('validity/notBefore').value)
      )
    end

    def issuer
      @issuer ||= Issuer.new(@node.at('issuer'))
    end

  end
end

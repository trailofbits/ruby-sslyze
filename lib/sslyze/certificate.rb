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
          @node.at('publicKey/modulus').inner_text,
          @node.at('publicKey/exponent').inner_text.to_i
        )
      end

      def public_key_algorithm
        @public_key_algorithm ||= @node.at('publicKeyAlgorithm').inner_text
      end

      def public_key_size
        @public_key_size ||= @node.at('publicKeySize').inner_text.chomp(' bits').to_i
      end

    end



    class Extensions

      class Extension
        def initialize(node)
          @node = node
        end

        def present?
          !@node.nil?
        end
      end

      class AuthorityInformationAccess < Extension

        def ca_issuers
          @ca_issuers ||= @node.search('CAIssuers/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

        def ocsp
          @ocsp ||= @node.search('OCSP/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

      end

      class X509v3CRLDistributionPoints < Extension

        #
        # @return [Array<String>]
        #
        def full_name
          @full_name ||= @node.search('FullName/listEntry').map do |full_name|
            full_name.inner_text
          end
        end

        #
        # @return [Array<URI>]
        #
        def uri
          @uri ||= @node.search('URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

      end

      class X509v3KeyUsage < Extension

        def key_encipherment
          @key_encipherment ||= @node.at('KeyEncipherment').inner_text
        end

        def digital_signature
          @digital_signature ||= @node.at('DigitalSignature').inner_text
        end

        def crl_sign
          @crl_sign ||= @node.at('CRLSign').inner_text
        end

        def certificate_sign
          @certificate_sign ||= @node.at('CertificateSign').inner_text
        end

      end

      class X509v3ExtendedKeyUsage < Extension

        def tls_web_client_authentication
          @tls_web_client_authentication ||= @node.at('TLSWebClientAuthentication').inner_text
        end

        def tls_web_server_authentication
          @tls_web_server_authentication ||= @node.at('TLSWebServerAuthentication').inner_text
        end

      end

      class X509v3CertificatePolicies < Extension

        def policy
          @policy ||= @node.at('Policy/listEntry').inner_text
        end

        def explicit_text
          @explicit_text ||= if (explicit_text = @node.at('ExplicitText/listEntry'))
                               explicit_text.inner_text
                             end
        end

        def cps
          @cps ||= @node.at('CPS/listEntry').inner_text
        end

        def user_notice
          @user_notice ||= if (user_notice = @node.at('userNotice/listEntry'))
                             user_notice.inner_text
                           end
        end

      end

      def initialize(node)
        @node = node
      end

      def x509v3_subject_key_identifier
        @x509v3_subject_key_identifier ||= @node.at('X509v3SubjectKeyIdentifier').inner_text
      end

      def authority_information_access
        @authority_information_access ||= AuthorityInformationAccess.new(@node.at('AuthorityInformationAccess'))
      end

      def x509v3_crl_distribution_points
        @x509v3_crl_distribution_points ||= X509v3CRLDistributionPoints.new(@node.at('X509v3CRLDistributionPoints'))
      end

      def x509v3_basic_constraints
        @x509v3_basic_constraints ||= @node.at('X509v3BasicConstraints').inner_text
      end

      def x509v3_key_usage
        @x509v3_key_usage ||= X509v3KeyUsage.new(@node.at('X509v3KeyUsage'))
      end

      def x509v3_extended_key_usage
        @x509v3_extended_key_usage ||= X509v3ExtendedKeyUsage.new(@node.at('X509v3ExtendedKeyUsage'))
      end

      def x509v3_subject_alternative_name(type = "DNS")
        @x509v3_subject_alternative_name ||= {}
        @x509v3_subject_alternative_name[type] ||= @node.search("X509v3SubjectAlternativeName/#{type}/listEntry").map do |dns|
          dns.inner_text
        end
      end

      def x509v3_authority_key_identifier
        @x509v3_authority_key_identifier ||= @node.at('X509v3AuthorityKeyIdentifier').inner_text
      end

      def x509v3_certificate_policies
        @x509v3_certificate_policies ||= X509v3CertificatePolicies.new(@node.at('X509v3CertificatePolicies'))
      end

    end

    class Subject

      def initialize(node)
        @node = node
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').inner_text
      end

      def organization_name
        @organization_name ||= @node.at('organizationName').inner_text
      end

      def business_category
        @business_category ||= @node.at('businessCategory').inner_text
      end

      def serial_number
        @serial_number ||= @node.at('serialNumber').inner_text.to_i
      end

      def common_name
        @common_name ||= @node.at('commonName').inner_text
      end

      def state_or_province_name
        @state_or_province_name ||= @node.at('stateOrProvinceName').inner_text
      end

      def country_name
        @country_name ||= @node.at('countryName').inner_text
      end

      def street_address
        @street_address ||= @node.at('streetAddress').inner_text
      end

      # TODO: oid-1.3.6.1.4.1.311.60.2.1.2
      # TODO: oid-1.3.6.1.4.1.311.60.2.1.3

      def locality_name
        @locality_name ||= @node.at('localityName').inner_text
      end

      def postal_code
        @postal_code ||= @node.at('postalCode').inner_text
      end

    end

    class Validity < Struct.new(:not_after, :not_before)
    end

    class Issuer

      def initialize(node)
        @node = node
      end

      def country_name
        @country_name || @node.at('countryName').inner_text
      end

      def common_name
        @common_name ||= @node.at('commonName').inner_text
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').inner_text
      end

      def organization_name
        @organization_name ||= @node.at('organizationName').inner_text
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

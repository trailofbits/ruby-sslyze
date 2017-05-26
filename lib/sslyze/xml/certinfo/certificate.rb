require 'sslyze/xml/plugin'
require 'sslyze/x509/name'

require 'openssl'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<certificate />` XML element.
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
        # The AS PEM information.
        #
        # @return [String]
        #
        def as_pem
          @as_pem ||= @node.at_xpath('asPEM').inner_text
        end

        alias to_s as_pem

        #
        # The parsed X509 certificate.
        #
        # @return [OpenSSL::X509::Certificate]
        #
        # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Certificate
        #
        # @since 1.0.0
        #
        def x509
          @x509 ||= OpenSSL::X509::Certificate.new(as_pem)
        end

        #
        # @return [Array<OpenSSL::X509::Extension>]
        #
        # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension
        #
        # @group OpenSSL Methods
        #
        def extensions
          x509.extensions
        end

        #
        # @return [X509::Name]
        #
        # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Name
        #
        # @group OpenSSL Methods
        #
        def issuer
          @issuer ||= X509::Name.new(x509.issuer)
        end

        #
        # @return [Time]
        #
        # @group OpenSSL Methods
        #
        def not_after
          x509.not_after
        end

        #
        # @return [Time]
        #
        # @group OpenSSL Methods
        #
        def not_before
          x509.not_before
        end

        #
        # @return [OpenSSL::PKey::RSA]
        #
        # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/PKey/RSA
        #
        # @group OpenSSL Methods
        #
        def public_key
          x509.public_key
        end

        #
        # @return [OpenSSL::BN]
        #
        # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/BN
        #
        # @group OpenSSL Methods
        #
        def serial
          x509.serial
        end

        #
        # @return [String]
        #
        # @group OpenSSL Methods
        #
        def signature_algorithm
          x509.signature_algorithm
        end

        #
        # @return [X509::Name]
        #
        # @group OpenSSL Methods
        #
        def subject
          @subject ||= X509::Name.new(x509.subject)
        end

        #
        # @return [String]
        #
        # @group OpenSSL Methods
        #
        def to_der
          x509.to_der
        end

        #
        # @return [String]
        #
        # @group OpenSSL Methods
        #
        def to_text
          x509.to_text
        end

        #
        # @return [Integer]
        #
        # @group OpenSSL Methods
        #
        def version
          x509.version
        end

        #
        # The position of the certificate within the cert chain.
        #
        # @return [Symbol, nil]
        #
        def position
          @position ||= if (value = @node['position'])
                          value.to_sym
                        end
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
        # The HPKP SHA256 Pin.
        #
        # @return [String]
        #
        # @since 1.0.0
        #
        def hpkp_sha256_pin
          @hpkp_sha256_pin ||= @node['hpkpSha256Pin']
        end

        #
        # The supplied server name indication.
        #
        # @return [String]
        #
        # @since 1.0.0
        #
        def supplied_server_name_indication
          @supplied_server_name_indication ||= @node['suppliedServerNameIndication']
        end

        #
        # Compares the other certificiate to this certificate.
        #
        # @param [Certificate] other
        #   The other certificate.
        #
        # @return [Boolean]
        #   Whether the other certificate has the same {#as_pem}.
        #
        # @since 1.0.0
        #
        def ==(other)
          other.kind_of?(self.class) && other.as_pem == as_pem
        end

      end
    end
  end
end

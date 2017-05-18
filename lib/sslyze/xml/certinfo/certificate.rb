require 'sslyze/xml/certinfo/certificate'

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
          @as_pem ||= @node.at('asPEM').inner_text
        end

        alias to_s as_pem

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

      end
    end
  end

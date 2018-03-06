require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Certinfo < Plugin
      class CertificateValidation
        #
        # Represents the `<hostnameValidation>` XML element.
        #
        # @since 1.0.0
        #
        class HostnameValidation

          include Types

          #
          # Initializes the element.
          #
          # @param [Nokogiri::XML::Element] node
          #   The `<hostnameValidation>` XML element.
          #
          def initialize(node)
            @node = node
          end

          #
          # Determines if the certificate Common Name matches the target domain
          # name.
          #
          # @return [Boolean]
          #
          def certificate_matches_server_hostname?
            Boolean[@node['certificateMatchesServerHostname']]
          end

          alias matches_server_hostname? certificate_matches_server_hostname?

          #
          # The server's domain name.
          #
          # @return [String]
          #
          def server_hostname
            @node['serverHostname']
          end

          alias to_s server_hostname

        end
      end
    end
  end
end

require 'sslyze/xml/plugin'
require 'sslyze/xml/http_headers/http_strict_transport_security'
require 'sslyze/xml/http_headers/http_public_key_pinning'

module SSLyze
  class XML
    #
    # Represents the `<http_headers>` XML element.
    #
    # @since 1.0.0
    #
    class HTTPHeaders < Plugin

      #
      # HTTP Strict-Transport-Security header information.
      #
      # @return [HTTPStrictTransportSecurity, nil]
      #
      def http_strict_transport_security
        @http_strict_transport_security ||= if (element = @node.at_xpath('httpStrictTransportSecurity'))
                                              HTTPStrictTransportSecurity.new(element)
                                            end
      end

      alias strict_transport_security http_strict_transport_security

      #
      # HTTP Public-Key-Pinning header information.
      #
      # @return [HTTPPublicKeyPinning, nil]
      #
      def http_public_key_pinning
        @http_public_key_pinning ||= if (element = @node.at_xpath('httpPublicKeyPinning'))
                                       HTTPPublicKeyPinning.new(element)
                                     end
      end

      alias public_key_pinning http_public_key_pinning

    end
  end
end

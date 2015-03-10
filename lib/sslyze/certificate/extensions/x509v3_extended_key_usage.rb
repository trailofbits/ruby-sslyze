require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      #
      # Represetns the `<X509v3ExtendedKeyUsage>` XML element.
      #
      class X509v3ExtendedKeyUsage < Extension

        #
        # TLS web client authentication.
        #
        # @return [String]
        #
        def tls_web_client_authentication
          @tls_web_client_authentication ||= @node.at('TLSWebClientAuthentication').inner_text
        end

        #
        # TLS web server authentication.
        #
        # @return [String]
        #
        def tls_web_server_authentication
          @tls_web_server_authentication ||= @node.at('TLSWebServerAuthentication').inner_text
        end

      end
    end
  end
end

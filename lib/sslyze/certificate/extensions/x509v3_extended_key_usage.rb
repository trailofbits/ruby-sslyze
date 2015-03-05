require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      class X509v3ExtendedKeyUsage < Extension

        def tls_web_client_authentication
          @tls_web_client_authentication ||= @node.at('TLSWebClientAuthentication').inner_text
        end

        def tls_web_server_authentication
          @tls_web_server_authentication ||= @node.at('TLSWebServerAuthentication').inner_text
        end

      end
    end
  end
end

require 'sslyze/x509/extension'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `extendedKeyUsage` X509v3 extension.
      #
      # @since 1.0.0
      #
      class ExtendedKeyUsage < Extension

        include Enumerable

        #
        # The allowed extended key uses.
        #
        # @return [Array<String>]
        #
        def uses
          @uses ||= value.split(', ')
        end

        #
        # Enumerates over the allowed extended key uses.
        #
        # @yield [use]
        #
        # @yieldparam [String] use
        #
        # @return [Enumerator]
        #
        def each(&block)
          uses.each(&block)
        end

        #
        # Determines if TLS Web Server Authentication is allowed.
        #
        # @return [Boolean]
        #
        def tls_web_server_authentication?
          uses.include?('TLS Web Server Authentication')
        end

        #
        # Determines if TLS Web Client Authentication is allowed.
        #
        # @return [Boolean]
        #
        def tls_web_client_authentication?
          uses.include?('TLS Web Client Authentication')
        end

      end
    end
  end
end

require 'sslyze/x509/extension'

require 'uri'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `crlDistributionPoints` X509v3 extension.
      #
      # @since 1.0.0
      #
      class CRLDistributionPoints < Extension

        include Enumerable

        #
        # All `URI:` values.
        #
        # @return [Array<URI::Generic>]
        #   All parsed `URI:` values from within the extension value.
        #
        def uris
          @uris ||= value.scan(/URI:(.+)/).map { |(uri)| URI.parse(uri) }
        end

        #
        # Enumerates over each {#uris uri} value within the
        # `crlDistributionPoiints` extension.
        #
        # @yield [uri]
        #   The given block will be passed each CRL URI.
        #
        # @yieldparam [URI::Generic] uri
        #   A parsed `URI:` value from within the extension value.
        #
        # @return [Enumerator]
        #   If no block is given, an Enumerator will be returned.
        #
        def each(&block)
          uris.each(&block)
        end

      end
    end
  end
end

require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/heartbleed/openssl_heartbleed'

module SSLyze
  class XML
    #
    # Represents the `<heartbleed/>` XML element.
    #
    # @since 1.0.0
    #
    class Heartbleed < Plugin

      #
      # Parses the `<openSslHeartbleed/>` XML element.
      #
      # @return [OpenSSLHeartbleed]
      #
      def openssl_heartbleed
        @openssl_heartbleed ||= if (element = @node.at('openSslHeartbleed'))
                                  OpenSSLHeartbleed.new(element)
                                end
      end

      alias openssl openssl_heartbleed

      #
      # Determines if the `<openSslHeartbleed/>` XML element is present.
      #
      # @return [Boolean]
      #
      def openssl_heartbleed?
        !openssl_heartbleed.nil?
      end

      alias openssl? openssl_heartbleed?

      #
      # Determines if the target is vulnerable to OpenSSL Heartbleed.
      #
      # @return [Boolean]
      #
      def has_openssl_heartbleed?
        openssl_heartbleed && openssl_heartbleed.is_vulnerable?
      end

      #
      # @see #has_openssl_heartbleed?
      #
      def is_vulnerable?
        has_openssl_heartbleed?
      end

      alias vulnerable? is_vulnerable?

    end
  end
end

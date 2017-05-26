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
        @openssl_heartbleed ||= if (element = @node.at_xpath('openSslHeartbleed'))
                                  OpenSSLHeartbleed.new(element)
                                end
      end

      alias openssl openssl_heartbleed

      #
      # @see #has_openssl_heartbleed?
      #
      def is_vulnerable?
        openssl_heartbleed && openssl_heartbleed.is_vulnerable?
      end

      alias vulnerable? is_vulnerable?

    end
  end
end

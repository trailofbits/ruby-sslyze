require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Heartbleed < Plugin
      #
      # Represents the `<openSslHeartbleed />` XML element.
      #
      # @since 1.0.0
      #
      class OpenSSLHeartbleed

        include Types

        #
        # Initializes the element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Determines if the target is vulnerable to OpenSSL HeartBleed.
        #
        # @return [Boolean]
        #
        def is_vulnerable?
          Boolean[@node['isVulnerable']]
        end

        alias vulnerable? is_vulnerable?

      end
    end
  end
end

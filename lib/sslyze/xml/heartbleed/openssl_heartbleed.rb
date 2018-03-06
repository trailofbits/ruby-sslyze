require 'sslyze/xml/plugin'
require 'sslyze/xml/attributes/is_vulnerable'

module SSLyze
  class XML
    class Heartbleed < Plugin
      #
      # Represents the `<openSslHeartbleed>` XML element.
      #
      # @since 1.0.0
      #
      class OpenSSLHeartbleed

        include Attributes::IsVulnerable

        #
        # Initializes the {OpenSSLHeartbleed} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<openSslHeartbleed>` XML element.
        #
        def initialize(node)
          @node = node
        end

      end
    end
  end
end

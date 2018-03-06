require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Reneg < Plugin
      #
      # Represents the `<sessionRenegotiation>` XML element.
      #
      # @since 1.0.0
      #
      class SessionRenegotiation

        include Types

        #
        # Initializes the {SessionRenegotiation} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<sessionRenegotiation>` XML element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Returns the `canBeClientInitiated` attribute.
        #
        # @return [Boolean]
        #
        def can_be_client_initiated?
          Boolean[@node['canBeClientInitiated']]
        end

        alias client_initiated? can_be_client_initiated?

        #
        # Returns the `isSecure` attribute.
        #
        # @return [Boolean]
        #
        def is_secure?
          Boolean[@node['isSecure']]
        end

        alias secure? is_secure?

      end
    end
  end
end

require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Resum < Plugin
      #
      # Represents the `<sessionResumptionWithTLSTickets/>` XML element.
      #
      # @since 1.0.0
      #
      class SessionResumptionWithTLSTickets

        include Types

        def initialize(node)
          @node = node
        end

        #
        # Returns the `error` attribute.
        #
        # @return [String, nil]
        #
        def error
          @error ||= @node['error']
        end

        #
        # Determines if there was an error.
        #
        # @return [Boolean]
        #
        def error?
          !error.nil?
        end

        #
        # Returns the `isSupported` attribute.
        #
        # @return [Boolean]
        #
        def is_supported?
          Boolean[@node['isSupported']]
        end

        alias supported? is_supported?

        #
        # Returns the descriptive reason.
        #
        # @return [String, nil]
        #
        def reason
          @reason ||= @node['reason']
        end

        #
        # Converts the element to a String.
        #
        # @return [String]
        #
        def to_s
          reason || ''
        end

      end
    end
  end
end

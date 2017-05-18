require 'sslyze/xml/types'

module SSLyze
  class XML
    module Attributes
      #
      # Common methods for the `isSupported` attribute.
      #
      # @since 1.0.0
      #
      module IsSupported

        include Types

        #
        # Parses the `isSupported` attribute.
        #
        # @return [Boolean]
        #
        def is_supported?
          Boolean[@node['isSupported']]
        end

        alias supported? is_supported?

      end
    end
  end
end

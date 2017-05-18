require 'sslyze/xml/types'

module SSLyze
  class XML
    module Attributes
      #
      # Common methods for the `isVulnerable` attribute.
      #
      # @since 1.0.0
      #
      module IsVulnerable

        include Types

        #
        # Parses the `isVulnerable` attribute.
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

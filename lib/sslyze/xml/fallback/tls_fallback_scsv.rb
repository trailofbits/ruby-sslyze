require 'sslyze/xml/plugin'
require 'sslyze/xml/is_supported'

module SSLyze
  class XML
    class Fallback < Plugin
      #
      # Represents the `<tlsFallbackScsv>` XML element.
      #
      class TLSFallbackSCSV

        include IsSupported

        #
        # Initializes the {TLSFallbackSCSV} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<tlsFallbackScsv>` XML element.
        #
        def initialize(node)
          @node = node
        end

      end
    end
  end
end

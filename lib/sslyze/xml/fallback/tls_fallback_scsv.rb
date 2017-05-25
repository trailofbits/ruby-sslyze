require 'sslyze/xml/plugin'
require 'sslyze/xml/is_supported'

module SSLyze
  class XML
    class Fallback < Plugin
      class TLSFallbackSCSV

        include IsSupported

        def initialize(node)
          @node = node
        end

      end
    end
  end
end

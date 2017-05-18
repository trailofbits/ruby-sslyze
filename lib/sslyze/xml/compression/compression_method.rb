require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class Compression < Plugin
      #
      # Represents the `<compressionMethod />` XML element.
      #
      # @since 1.0.0
      #
      class CompressionMethod

        include Types

        def initialize(node)
          @node = node
        end

        #
        # Specifies whether Compression is supported.
        #
        # @return [Boolean]
        #
        def is_supported?
          Boolean[@node['isSupported']]
        end

        #
        # The type of compression.
        #
        # @return [Symbol]
        #
        def type
          @type ||= @node['type'].to_sym
        end

        alias supported? is_supported?

      end
    end
  end
end

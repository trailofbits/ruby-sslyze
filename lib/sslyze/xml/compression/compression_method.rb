require 'sslyze/xml/plugin'
require 'sslyze/xml/attributes/is_supported'

module SSLyze
  class XML
    class Compression < Plugin
      #
      # Represents the `<compressionMethod>` XML element.
      #
      # @since 1.0.0
      #
      class CompressionMethod

        include Attributes::IsSupported

        #
        # Initializes the {CompressionMethod} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<compressionMethod>` XML element.
        #
        def initialize(node)
          @node = node
        end

        #
        # The type of compression.
        #
        # @return [Symbol]
        #
        def type
          @type ||= @node['type'].to_sym
        end

      end
    end
  end
end

require 'sslyze/xml/plugin'
require 'sslyze/xml/compression/compression_method'

module SSLyze
  class XML
    #
    # Represents the `<compression>` XML element.
    #
    # @since 1.0.0
    #
    class Compression < Plugin

      #
      # Parses the `<compressionMethod>` XML element.
      #
      # @return [CompressionMethod]
      #
      # @raise [PluginException]
      #
      def deflate
        @compression_method ||= exception! do
          CompressionMethod.new(
            @node.at_xpath('compressionMethod[@type="DEFLATE"]')
          )
        end
      end

      #
      # @see CompressionMethod#is_supported?
      #
      def deflate?
        deflate.is_supported?
      end

    end
  end
end

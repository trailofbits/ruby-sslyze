require 'sslyze/xml/plugin'
require 'sslyze/xml/compression/compression_method'

module SSLyze
  class XML
    #
    # Represents the `<compression/>` XML element.
    #
    # @since 1.0.0
    #
    class Compression < Plugin

      #
      # Parses the `<compressionMethod />` XML element.
      #
      # @return [CompressionMethod]
      #
      def compression_method
        @compression_method ||= CompressionMethod.new(@node.at('compressionMethod'))
      end

      def is_supported?
        compression_method.is_supported?
      end

      alias supported? is_supported?

    end
  end
end

require 'sslyze/xml/plugin'

module SSLyze
  class XML
    #
    # Represents the `<fallback>` XML element.
    #
    # @since 1.0.0
    #
    class Fallback < Plugin

      #
      # Parses the `<tlsFallbackScsv>` XML element.
      #
      # @return [TLSFallbackSCSV]
      #
      # @raise [PluginException]
      #
      def tls_fallback_scsv
        @tls_fallback_scsv ||= exception! do
          TLSFallbackSCSV.new(@node.at_xpath('tlsFallbackScsv'))
        end
      end

      #
      # @see TLSFallbackSCSV#is_supported?
      #
      # @raise [PluginException]
      #
      def is_supported?
        tls_fallback_scsv.is_supported?
      end

      alias supported? is_supported?

    end
  end
end

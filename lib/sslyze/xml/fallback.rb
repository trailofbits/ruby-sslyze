require 'sslyze/xml/plugin'

module SSLyze
  class XML
    class Fallback < Plugin

      #
      # @return [TLSFallbackSCSV]
      #
      def tls_fallback_scsv
        @tls_fallback_scsv ||= TLSFallbackSCSV.new(
          @node.at_xpath('tlsFallbackScsv')
        )
      end

      #
      # @see TLSFallbackSCSV#is_supported?
      #
      def is_supported?
        tls_fallback_scsv.is_supported?
      end

      alias supported? is_supported?

    end
  end
end

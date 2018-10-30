require 'sslyze/xml/plugin'

module SSLyze
  class XML
    #
    # Represents the `<openssl_ccs>` XML element.
    #
    # @since 1.0.0
    #
    class OpenSSLCCS < Plugin

      #
      # @return [OpenSSLCCSInjection]
      #
      # @raise [PluginException]
      #
      def openssl_ccs_injection
        @openssl_ccs_injection ||= exception! do
          OpenSSLCCSInjection.new(@node.at_xpath('openSslCcsInjection'))
        end
      end

      alias injection openssl_ccs_injection

      #
      # @return [Boolean]
      #
      # @raise [PluginException]
      #
      def is_vulnerable?
        openssl_ccs_injection.is_vulnerable?
      end

      alias vulnerable? is_vulnerable?

    end
  end
end

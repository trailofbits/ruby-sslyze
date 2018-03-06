require 'sslyze/xml/plugin'
require 'sslyze/xml/attributes/is_vulnerable'

module SSLyze
  class XML
    class OpenSSLCCS < Plugin
      #
      # Represents the `<openSslCcsInjection />` XML element.
      #
      # @since 1.0.0
      #
      class OpenSSLCCSInjection

        include Attributes::IsVulnerable

        #
        # Initializes the {OpenSSLCCSInjection} object.
        #
        def initialize(node)
          @node = node
        end

      end
    end
  end
end

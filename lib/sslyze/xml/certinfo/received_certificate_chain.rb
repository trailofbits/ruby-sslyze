require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/certinfo/has_certificates'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<receivedCertificateChain />` XML element.
      #
      # @since 1.0.0
      #
      class ReceivedCertificateChain

        include Types
        include HasCertificates

        def initialize(node)
          @node = node
        end

        #
        # @return [Boolean]
        #
        def is_chain_order_valid?
          Boolean[@node['isChainOrderValid']]
        end

        #
        # @return [Boolean]
        #
        def contains_anchor_certificate?
          Boolean[@node['containsAnchorCertificate']]
        end

      end
    end
  end
end

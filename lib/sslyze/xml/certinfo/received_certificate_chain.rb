require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/certinfo/has_certificates'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<receivedCertificateChain>` XML element.
      #
      # @since 1.0.0
      #
      class ReceivedCertificateChain

        include Types
        include HasCertificates

        #
        # Initializes the {ReceivedCertificateChain} object.
        #
        # @param [Nokogiri::XML::Element] node
        #
        def initialize(node)
          @node = node
        end

        #
        # Parses the `isChainOrderValid` XML attribute.
        #
        # @return [Boolean]
        #
        def is_chain_order_valid?
          Boolean[@node['isChainOrderValid']]
        end

        #
        # Parses the `containsAnchorCertificate` XML attribute.
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

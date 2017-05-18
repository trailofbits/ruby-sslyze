require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/certinfo/received_certificate_chain/certificate'

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

        def initialize(node)
          @node = node
        end

        #
        # Enumerates over each certificate in the chain.
        #
        # @yield [cert]
        #   The given block will be passed each certificate.
        #
        # @yieldparam [Certificate] cert
        #   A certificate in the chain.
        #
        # @return [Enumerator]
        #   If no block was given, an Enumerator will be returned.
        #
        def each_certificate
          return enum_for(__method__) unless block_given?

          @node.search('certificate').each do |element|
            yield Certificate.new(element)
          end
        end

        alias each_cert each_certificate

        #
        # Returns all certificates in the chain.
        #
        # @return [Array<Certificate>]
        #
        def certificates
          each_certificate.to_a
        end

        alias certs certificates

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

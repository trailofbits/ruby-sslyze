require 'sslyze/types'
require 'sslyze/key_exchange'

module SSLyze
  #
  # Represents the `<cipherSuite>` XML element.
  #
  class CipherSuite

    include Types

    #
    # Initializes the cipher suite.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<cipherSuite>` XML element.
    #
    def initialize(node)
      @node = node
    end

    #
    # The cipher suite name.
    #
    # @return [String]
    #
    def name
      @name ||= @node['name']
    end

    #
    # The connection status when the cipher suite was used.
    #
    def connection_status
      @connection_status ||= @node['connectionStatus']
    end

    def anonymous?
      Boolean[@node['anonymous']]
    end

    #
    # Key exchange information.
    #
    # @return [KeyExchange, nil]
    #
    def key_exchange
      @key_exchange ||= if (key_exchange_node = @node.at('keyExchange'))
                          KeyExchange.new(key_exchange_node)
                        end
    end

  end
end

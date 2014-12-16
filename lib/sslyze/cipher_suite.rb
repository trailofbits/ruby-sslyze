require 'sslyze/types'
require 'sslyze/key_exchange'

module SSLyze
  class CipherSuite

    include Types

    def initialize(node)
      @node = node
    end

    def name
      @name ||= @node['name']
    end

    def connection_status
      @connection_status ||= @node['connectionStatus']
    end

    def anonymous?
      Boolean[@node['anonymous']]
    end

    def key_exchange
      @key_exchange ||= if (key_exchange_node = @node.at('keyExchange'))
                          KeyExchange.new(key_exchange_node)
                        end
    end

  end
end

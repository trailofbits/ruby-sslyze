require 'sslyze/key_exchange'

module SSLyze
  class CipherSuite

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
      case @node['anonymous']
      when 'True'  then true
      when 'False' then false
      end
    end

    def key_exchange
      @key_exchange ||= if (key_exchange_node = node.at('keyExchange'))
                          KeyExchange.new(key_exchange_node)
                        end
    end

  end
end

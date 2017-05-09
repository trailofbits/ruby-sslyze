require 'sslyze/xml/types'
require 'sslyze/xml/key_exchange'
require 'sslyze/cipher_suites'

module SSLyze
  class XML
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

      alias openssl_name name

      #
      # Maps the OpenSSL cipher name to it's RFC name.
      #
      # @return [String, nil]
      #
      def rfc_name
        CipherSuites::RFC_NAMES[name]
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

      alias to_s name

    end
  end
end

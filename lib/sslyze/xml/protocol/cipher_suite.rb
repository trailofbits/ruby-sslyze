require 'sslyze/cipher_suites'
require 'sslyze/xml/types'
require 'sslyze/xml/protocol/cipher_suite/key_exchange'

module SSLyze
  class XML
    class Protocol
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

        alias rfc_name name

        #
        # Maps the RFC cipher name to it's OpenSSL name.
        #
        # @return [String, nil]
        #
        # @since 1.0.0
        #
        def openssl_name
          CipherSuites::OPENSSL_NAMES[rfc_name]
        end

        #
        # The connection status when the cipher suite was used.
        #
        # @return [String]
        #
        def connection_status
          @connection_status ||= @node['connectionStatus']
        end

        #
        # @return [Boolean]
        #
        def anonymous?
          Boolean[@node['anonymous']]
        end

        #
        # The key size required by the cipher suite.
        #
        # @return [Integer, nil]
        #
        # @since 1.0.0
        #
        def key_size
          @key_size ||= if (value = @node['keySize'])
                          value.to_i
                        end
        end

        #
        # Key exchange information.
        #
        # @return [KeyExchange, nil]
        #
        def key_exchange
          @key_exchange ||= if (element = @node.at('keyExchange'))
                              KeyExchange.new(element)
                            end
        end

        alias to_s name

      end
    end
  end
end

require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/protocol/cipher_suite'

module SSLyze
  class XML
    #
    # Represents the `<sslv2>`, `<sslv3>`, `<tls1>`, `<tls1_1>`, `<tlsv1_2>`
    # XML elements.
    #
    class Protocol < Plugin

      include Types

      # SSL protocol name.
      #
      # @return [Symbol]
      attr_reader :name

      #
      # Initializes the protocol.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML element.
      #
      def initialize(node)
        @node = node
        @name = @node.name.to_sym
      end

      #
      # Determines whether the protocol is supported.
      #
      # @return [Boolean]
      #   Specifies whether any cipher suite was accepted.
      #
      # @raise [PluginException]
      #
      # @since 1.0.0
      #
      def is_protocol_supported?
        exception! { Boolean[@node['isProtocolSupported']] }
      end

      alias is_supported? is_protocol_supported?
      alias supported? is_protocol_supported?

      #
      # Enumerates over every rejected cipher suite.
      #
      # @yield [cipher_suite]
      #
      # @yieldparam [CipherSuite] cipher_suite
      #
      # @return [Enumerator]
      #
      # @raise [PluginException]
      #
      def each_rejected_cipher_suite
        return enum_for(__method__) unless block_given?

        exception! do
          @node.xpath('rejectedCipherSuites/cipherSuite').each do |cipher_suite|
            yield CipherSuite.new(cipher_suite)
          end
        end
      end

      #
      # The rejected cipher suites.
      #
      # @return [Array<CipherSuite>]
      #
      def rejected_cipher_suites
        each_rejected_cipher_suite.to_a
      end

      #
      # Enumerates over every accepted cipher suite.
      #
      # @yield [cipher_suite]
      #
      # @yieldparam [CipherSuite] cipher_suite
      #
      # @return [Enumerator]
      #
      # @raise [PluginException]
      #
      def each_accepted_cipher_suite
        return enum_for(__method__) unless block_given?

        exception! do
          @node.xpath('acceptedCipherSuites/cipherSuite').each do |cipher_suite|
            yield CipherSuite.new(cipher_suite)
          end
        end
      end

      #
      # The accepted cipher suites.
      #
      # @return [Array<CipherSuite>]
      #
      def accepted_cipher_suites
        each_accepted_cipher_suite.to_a
      end

      #
      # The preferred cipher suite.
      #
      # @return [CipherSuite, nil]
      #
      # @since 1.0.0
      #
      # @raise [PluginException]
      #
      def preferred_cipher_suite
        @preferred_cipher_suite ||= exception! do
          if (element = @node.at_xpath('preferredCipherSuite/cipherSuite'))
            CipherSuite.new(element)
          end
        end
      end

      #
      # Enumerates over every errored cipher suite.
      #
      # @yield [cipher_suite]
      #
      # @yieldparam [CipherSuite] cipher_suite
      #
      # @return [Enumerator]
      #
      # @raise [PluginException]
      #
      # @since 1.0.0
      #
      def each_error
        return enum_for(__method__) unless block_given?

        exception! do
          @node.xpath('errors/cipherSuite').each do |cipher_suite|
            yield CipherSuite.new(cipher_suite)
          end
        end
      end

      #
      # The errored cipher suites.
      #
      # @return [Array<CipherSuite>]
      #
      # @raise [PluginException]
      #
      # @since 1.0.0
      #
      def errors
        each_error.to_a
      end

    end
  end
end

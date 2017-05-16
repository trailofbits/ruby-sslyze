require 'sslyze/xml/cipher_suite'
require 'sslyze/xml/types'

module SSLyze
  class XML
    #
    # Represents the `<sslv2>`, `<sslv3>`, `<tls1>`, `<tls1_1>`, `<tlsv1_2>`
    # XML elements.
    #
    class Protocol

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
      # @since 1.0.0
      #
      def is_protocol_supported?
        Boolean[@node['isProtocolSupported']]
      end

      alias is_supported? is_protocol_supported?
      alias supported? is_protocol_supported?

      #
      # Descriptive title.
      #
      # @return [String]
      #
      def title
        @title ||= @node['title']
      end

      #
      # The exception message.
      #
      # @return [String, nil]
      #
      # @since 1.0.0
      #
      def exception
        @exception ||= @node['exception']
      end

      #
      # Enumerates over every rejected cipher suite.
      #
      # @yield [cipher_suite]
      #
      # @yieldparam [CipherSuite] cipher_suite
      #
      # @return [Enumerator]
      #
      def each_rejected_cipher_suite
        return enum_for(__method__) unless block_given?

        @node.search('rejectedCipherSuites/cipherSuite').each do |cipher_suite|
          yield CipherSuite.new(cipher_suite)
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
      def each_accepted_cipher_suite
        return enum_for(__method__) unless block_given?

        @node.search('acceptedCipherSuites/cipherSuite').each do |cipher_suite|
          yield CipherSuite.new(cipher_suite)
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
      # Enumerates over every preferred cipher suite.
      #
      # @yield [cipher_suite]
      #
      # @yieldparam [CipherSuite] cipher_suite
      #
      # @return [Enumerator]
      #
      def each_preferred_cipher_suite
        return enum_for(__method__) unless block_given?

        @node.search('preferredCipherSuites/cipherSuite').each do |cipher_suite|
          yield CipherSuite.new(cipher_suite)
        end
      end

      #
      # The preferred cipher suites.
      #
      # @return [Array<CipherSuite>]
      #
      def preferred_cipher_suites
        each_preferred_cipher_suite.to_a
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
      # @since 1.0.0
      #
      def each_error
        return enum_for(__method__) unless block_given?

        @node.search('errors/cipherSuite').each do |cipher_suite|
          yield CipherSuite.new(cipher_suite)
        end
      end

      #
      # The errored cipher suites.
      #
      # @eturn [Array<CipherSuite>]
      #
      # @since 1.0.0
      #
      def errors
        each_error.to_a
      end

    end
  end
end

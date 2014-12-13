require 'sslyze/cipher_suite'

module SSLyze
  class Protocol

    def initialize(node)
      @node = node
    end

    #
    # @return [String]
    #
    def name
      @node.name
    end

    #
    # @return [String]
    #
    def title
      @title ||= @node['title']
    end

    #
    # @raise [NotImplemnetedError]
    #
    # @todo figure out what `<errors />` contains.
    #
    def each_error
      raise(NotImplementedError,"#{__method__} not implemented")
    end

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
    # @return [Array<CipherSuite>]
    #
    def rejected_cipher_suites
      each_rejected_cipher_suite.to_a
    end

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
    # @return [Array<CipherSuite>]
    #
    def accepted_cipher_suites
      each_accepted_cipher_suite.to_a
    end

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
    # @return [Array<CipherSuite>]
    #
    def preferred_cipher_suites
      each_preferred_cipher_suite.to_a
    end

  end
end

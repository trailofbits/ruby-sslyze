require 'sslyze/certificate'

module SSLyze
  #
  # Represents the `<certificateChain>` XML element.
  #
  class CertificateChain

    include Enumerable

    #
    # Initializes the certificate chain.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<certificateChain>` XML element.
    #
    def initialize(node)
      @node = node
    end

    #
    # Enumerates over each certificate in the chain.
    #
    # @yield [certificate]
    # 
    # @yieldparam [Certificate] certificate
    #
    # @return [Enumerator]
    #
    def each
      return enum_for(__method__) unless block_given?

      @node.search('certificate').each do |certificate|
        yield Certificate.new(certificate)
      end
    end

    #
    # The leaf certificate in the chain.
    #
    # @return [Certificate, nil]
    #
    def leaf
      @leaf ||= if (certificate = @node.at('certificate[@position="leaf"]'))
                  Certificate.new(certificate)
                end
    end

    #
    # Enumerates over the intermediate certificates in the chain.
    #
    # @yield [certificate]
    #
    # @yieldparam [Certificate] certificate
    #
    # @return [Enumerator]
    #
    def intermediate
      return enum_for(__method__) unless block_given?

      @node.search('certificate[@position="intermediate"]').each do |certificate|
        yield Certificate.new(certificate)
      end
    end

    #
    # The root certificate.
    #
    # @return [Certificate, nil]
    #
    def root
      if (certificate = @node.at('certificate[@position="intermediate"]:last-child'))
        Certificate.new(certificate)
      end
    end

  end
end

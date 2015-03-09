require 'sslyze/certificate'

module SSLyze
  class CertificateChain

    include Enumerable

    def initialize(node)
      @node = node
    end

    def each
      return enum_for(__method__) unless block_given?

      @node.search('certificate').each do |certificate|
        yield Certificate.new(certificate)
      end
    end

    def leaf
      @leaf ||= if (certificate = @node.at('certificate[@position="leaf"]'))
                  Certificate.new(certificate)
                end
    end

    def intermediate
      return enum_for(__method__) unless block_given?

      @node.search('certificate[@position="intermediate"]').each do |certificate|
        yield Certificate.new(certificate)
      end
    end

    def root
      if (certificate = @node.at('certificate[@position="intermediate"]:last-child'))
        Certificate.new(certificate)
      end
    end

  end
end

require 'sslyze/types'

module SSLyze
  class OCSPResponse

    include Types

    def initialize(node)
      @node = node
    end

    #
    # @return [Boolean]
    #
    def trusted?
      !@node.nil? && Boolean[@node.at('@isTrustedByMozillaCAStore').value]
    end

    def path
      @path ||= @node.at('ocspResponse')
    end

  end
end

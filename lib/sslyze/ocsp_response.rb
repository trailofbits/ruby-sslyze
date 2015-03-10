require 'sslyze/types'

module SSLyze
  #
  # Represents the `<ocspStapling>` XML element.
  #
  class OCSPResponse

    include Types

    #
    # Initializes the OCSP response.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<ocspStapling>` XML element.
    #
    def initialize(node)
      @node = node
    end

    #
    # Specifies whether the response was trusted.
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

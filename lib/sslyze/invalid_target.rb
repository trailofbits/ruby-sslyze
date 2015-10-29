module SSLyze
  #
  # Represents the `<invalidTarget>` XML element.
  #
  class InvalidTarget

    #
    # Initializes the invalid target.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<invalid>` XML element.
    #
    def initialize(node)
      @node = node
    end

    #
    # The host name of the target.
    #
    # @return [String]
    #
    def host
      @host ||= @node.text
    end

    #
    # The error from the scan.
    #
    # @return [String]
    #
    def error
      @ip ||= @node['error']
    end
  end
end

require 'sslyze/xml/attributes/error'

module SSLyze
  class XML
    #
    # Represents the `<invalidTarget>` XML element.
    #
    class InvalidTarget

      include Attributes::Error

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
        @host ||= @node.inner_text
      end

    end
  end
end

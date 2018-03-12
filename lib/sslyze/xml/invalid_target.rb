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
      # The target name.
      #
      # @return [String]
      #
      # @since 1.1.0
      #
      def target
        @target ||= @node.inner_text
      end

      #
      # The host component of the target.
      #
      # @return [String]
      #
      def host
        @host ||= target.split(':',2).first
      end

      #
      # The port component of the target.
      #
      # @return [Integer]
      #
      # @since 1.1.0
      #
      def port
        @port ||= target.split(':',2).last.to_i
      end


    end
  end
end

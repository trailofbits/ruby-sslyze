module SSLyze
  class Certificate
    class Extensions
      #
      # Represents a SSL extension XML element.
      #
      class Extension

        #
        # Initializes the extension.
        #
        # @param [Nokogiri::XML::Node] node
        #   The extension node.
        #
        def initialize(node)
          @node = node
        end

        def present?
          !@node.nil?
        end

      end
    end
  end
end

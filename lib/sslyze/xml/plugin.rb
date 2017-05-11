module SSLyze
  class XML
    #
    # Common base class for all plugin elements.
    #
    # @since 1.0.0
    #
    class Plugin

      def initialize(node)
        @node = node
      end

      #
      # The plugin's title.
      #
      # @return [String, nil]
      #
      def title
        @title ||= @node['title']
      end

      #
      # Any exception raised by the plugin.
      #
      # @return [String, nil]
      #
      def exception
        @exception ||= @node['exception']
      end

      #
      # Determines if an exception was raised.
      #
      # @return [Boolean]
      #
      def exception?
        !exception.nil?
      end

      #
      # Converts the plugin to a String.
      #
      # @return [String]
      #   The plugin title or an empty String.
      #
      def to_s
        title || ''
      end

    end
  end
end

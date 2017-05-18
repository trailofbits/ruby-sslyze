require 'sslyze/xml/attributes/title'
require 'sslyze/xml/attributes/exception'

module SSLyze
  class XML
    #
    # Common base class for all plugin elements.
    #
    # @since 1.0.0
    #
    class Plugin

      include Attributes::Title
      include Attributes::Exception

      def initialize(node)
        @node = node
      end

    end
  end
end

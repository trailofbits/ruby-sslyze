require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

module SSLyze
  class XML
    class HTTPHeaders < Plugin
      #
      # Represents the `<httpStrictTransportSecurity/>` XML element.
      #
      # @since 1.0.0
      #
      class HTTPStrictTransportSecurity

        include Types

        def initialize(node)
          @node = node
        end

        #
        # @return [Boolean]
        #
        def include_sub_domains?
          Boolean[@node['includeSubDomains']]
        end

        #
        # @return [Boolean]
        #
        def is_supported?
          Boolean[@node['isSupported']]
        end

        alias supported? is_supported?

        #
        # @return [Integer, nil]
        #
        def max_age
          @max_age ||= if (value = @node['maxAge'])
                         value.to_i
                       end
        end

        #
        # @return [Boolean]
        #
        def preload?
          Boolean[@node['preload']]
        end

        #
        # @return [String, nil]
        #
        def exception
          @exception ||= @node['exception']
        end

      end
    end
  end
end

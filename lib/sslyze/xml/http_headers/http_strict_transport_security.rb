require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/attributes/is_supported'
require 'sslyze/xml/attributes/exception'

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
        include Attributes::IsSupported
        include Attributes::Exception

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

      end
    end
  end
end

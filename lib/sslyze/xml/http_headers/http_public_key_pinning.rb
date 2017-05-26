require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/attributes/is_supported'
require 'sslyze/xml/attributes/exception'

module SSLyze
  class XML
    class HTTPHeaders < Plugin
      #
      # Represents the `<httpPublicKeyPinning/>` XML element.
      #
      # @since 1.0.0
      #
      class HTTPPublicKeyPinning

        include Types
        include Attributes::IsSupported
        include Attributes::Exception

        def initialize(node)
          @node = node
        end

        #
        # @yield [sha256]
        #
        # @yieldparam [String] sha256
        #
        # @return [Enumerator]
        #
        def each_pin_sha256
          return enum_for(__method__) unless block_given?

          @node.xpath('pinSha256').each do |element|
            yield element.inner_text
          end
        end

        alias each_sha256 each_pin_sha256

        #
        # @return [Array<String>]
        #
        def pin_sha256s
          each_pin_sha256.to_a
        end

        alias sha256s pin_sha256s

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
        def report_only
          Boolean[@node['reportOnly']]
        end

        #
        # @return [String, nil]
        #
        def report_uri
          @report_uri ||= case (value = @node['reportUri'])
                          when nil, 'None' then nil
                          else                  value
                          end
        end

        #
        # @return [Boolean]
        #
        def is_valid_pin_configured?
          Boolean[@node['isValidPinConfigured']]
        end

        #
        # @return [Boolean]
        #
        def is_backup_pin_configured?
          Boolean[@node['isBackupPinConfigured']]
        end

      end
    end
  end
end

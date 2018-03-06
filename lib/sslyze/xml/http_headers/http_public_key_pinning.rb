require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/attributes/is_supported'
require 'sslyze/xml/attributes/exception'

module SSLyze
  class XML
    class HTTPHeaders < Plugin
      #
      # Represents the `<httpPublicKeyPinning>` XML element.
      #
      # @since 1.0.0
      #
      class HTTPPublicKeyPinning

        include Types
        include Attributes::IsSupported
        include Attributes::Exception

        #
        # Initializes the {HTTPPublicKeyPinning} element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Parses each `pinSha256` XML element.
        #
        # @yield [sha256]
        #   Yields each SHA256 checksum.
        #
        # @yieldparam [String] sha256
        #   An individual pinned SHA256 checksum.
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
        # @see #each_pin_sha256
        #
        def pin_sha256s
          each_pin_sha256.to_a
        end

        alias sha256s pin_sha256s

        #
        # Parses the `includeSubDomains` XML attribute.
        #
        # @return [Boolean]
        #
        def include_sub_domains?
          Boolean[@node['includeSubDomains']]
        end

        #
        # Parses the `maxAge` attribute.
        #
        # @return [Integer, nil]
        #
        def max_age
          @max_age ||= if (value = @node['maxAge'])
                         value.to_i
                       end
        end

        #
        # Parses the `reportOnly` XML attribute.
        #
        # @return [Boolean]
        #
        def report_only
          Boolean[@node['reportOnly']]
        end

        #
        # Parses the `reportUri` XML attribute.
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
        # Parses the `isValidPinConfigured` XML attribute.
        #
        # @return [Boolean]
        #
        def is_valid_pin_configured?
          Boolean[@node['isValidPinConfigured']]
        end

        #
        # Parses the `isBackupPinConfigured` XML attribute.
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

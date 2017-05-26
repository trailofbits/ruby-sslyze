require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

require 'time'

module SSLyze
  class XML
    class Certinfo < Plugin
      class OCSPStapling
        #
        # Represents the `<ocspResponse/>` XML element.
        #
        # @since 1.0.0
        #
        class OCSPResponse

          include Types

          def initialize(node)
            @node = node
          end

          #
          # The responder's ID.
          #
          # @return [String]
          #
          # @note Parses the `responderID` attribute.
          #
          def responder_id
            @responder_id ||= @node.at_xpath('responderID').inner_text
          end

          alias id responder_id

          #
          # @return [Time]
          #
          def produced_at
            @produced_at ||= Time.parse(@node.at_xpath('producedAt').inner_text)
          end

          alias to_time produced_at

          #
          # @return [Symbol]
          #
          def response_status
            @response_status ||= @node.at_xpath('responseStatus').inner_text.to_sym
          end

          alias status response_status

          #
          # Determines if the response status was successful.
          #
          # @return [Boolean]
          #
          def successful?
            response_status == :successful
          end

          #
          # Specifies whether the OCSP Response is trusted by Mozilla's CA
          # Store.
          #
          # @return [Boolean]
          #
          def is_trusted_by_mozilla_ca_store?
            Boolean[@node['isTrustedByMozillaCAStore']]
          end

          alias trusted? is_trusted_by_mozilla_ca_store?

        end
      end
    end
  end
end

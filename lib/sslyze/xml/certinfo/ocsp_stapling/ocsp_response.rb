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
          # @return [String, nil]
          #
          # @note Parses the `responderID` attribute.
          #
          def responder_id
            @responder_id ||= @node['responderID']
          end

          alias id responder_id

          #
          # @return [Time, nil]
          #
          def produced_at
            @produced_at ||= if (value = @node['producedAt'])
                               Time.parse(value)
                             end
          end

          alias to_time produced_at

          #
          # @return [Symbol, nil]
          #
          def response_status
            @response_status ||= if (value = @node['responseStatus'])
                                   value.to_sym
                                 end
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

        end
      end
    end
  end
end

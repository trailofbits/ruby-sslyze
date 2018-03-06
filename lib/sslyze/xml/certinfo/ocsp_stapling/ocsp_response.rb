require 'sslyze/xml/plugin'
require 'sslyze/xml/types'

require 'time'

module SSLyze
  class XML
    class Certinfo < Plugin
      class OCSPStapling
        #
        # Represents the `<ocspResponse>` XML element.
        #
        # @since 1.0.0
        #
        class OCSPResponse

          include Types

          #
          # Initializes the {OCSPResponse} object.
          #
          # @param [Nokogiri::XML::Element] node
          #   The `<ocspResponse>` XML element.
          #
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
          # When the response was produced at.
          #
          # @return [Time]
          #
          def produced_at
            @produced_at ||= Time.parse(@node.at_xpath('producedAt').inner_text)
          end

          alias to_time produced_at

          #
          # The status.
          #
          # @return [:successful]
          #
          def status
            @status ||= @node['status'].downcase.to_sym
          end

          #
          # Determines if the response status was successful.
          #
          # @return [Boolean]
          #
          def successful?
            status == :successful
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

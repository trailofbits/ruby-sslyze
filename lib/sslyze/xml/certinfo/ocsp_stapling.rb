require 'sslyze/xml/plugin'
require 'sslyze/xml/attributes/is_supported'
require 'sslyze/xml/certinfo/ocsp_stapling/ocsp_response'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<ocspStapling>` XML element.
      #
      # @since 1.0.0
      #
      class OCSPStapling

        include Attributes::IsSupported

        #
        # Initializes the {OCSPStapling} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<ocspStapling>` XML element.
        #
        def initialize(node)
          @node = node
        end

        #
        # The OCSP Response.
        #
        # @return [OCSPResponse, nil]
        #
        # @note Parses the `<ocspResponse>` XML element.
        #
        def ocsp_response
          @ocsp_response ||= if (element = @node.at_xpath('ocspResponse'))
                               OCSPResponse.new(element)
                             end
        end

        alias response ocsp_response

      end
    end
  end
end

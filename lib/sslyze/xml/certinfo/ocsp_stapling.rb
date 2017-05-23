require 'sslyze/xml/plugin'
require 'sslyze/xml/attributes/is_supported'
require 'sslyze/xml/certinfo/ocsp_stapling/ocsp_response'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<ocspStapling />` XML element.
      #
      # @since 1.0.0
      #
      class OCSPStapling

        include Attributes::IsSupported

        def initialize(node)
          @node = node
        end

        #
        # The OCSP Response.
        #
        # @return [OCSPResponse, nil]
        #
        # @note Parses the `<ocspResponse />` XML element.
        #
        def ocsp_response
          @ocsp_response ||= if (element = @node.at('ocspResponse'))
                               OCSPResponse.new(element)
                             end
        end

        alias response ocsp_response

        #
        # Determines if the {#ocsp_response} is available.
        #
        # @return [Boolean]
        #
        def ocsp_response?
          !ocsp_response.nil?
        end

        alias response? ocsp_response?

      end
    end
  end
end

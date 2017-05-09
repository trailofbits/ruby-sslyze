module SSLyze
  class XML
    class Certificate
      #
      # Represents the `<issuer>` XML element.
      #
      class Issuer

        #
        # Initializes the issuer.
        #
        # @param [Nokogiri::XML::Node] node
        #   The `<issuer>` element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Country name.
        #
        # @return [String]
        #
        def country_name
          @country_name || @node.at('countryName').inner_text
        end

        #
        # Common name.
        #
        # @return [String]
        #
        def common_name
          @common_name ||= @node.at('commonName').inner_text
        end

        #
        # Organizational unit name.
        #
        # @return [String]
        #
        def organizational_unit_name
          @organizational_unit_name ||= @node.at('organizationalUnitName').inner_text
        end

        #
        # Organization name.
        #
        # @return [String]
        #
        def organization_name
          @organization_name ||= @node.at('organizationName').inner_text
        end

      end
    end
  end
end

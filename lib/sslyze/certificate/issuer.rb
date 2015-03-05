module SSLyze
  class Certificate
    class Issuer

      def initialize(node)
        @node = node
      end

      def country_name
        @country_name || @node.at('countryName').inner_text
      end

      def common_name
        @common_name ||= @node.at('commonName').inner_text
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').inner_text
      end

      def organization_name
        @organization_name ||= @node.at('organizationName').inner_text
      end

    end
  end
end

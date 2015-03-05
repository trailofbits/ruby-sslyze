module SSLyze
  class Certificate
    class Subject

      def initialize(node)
        @node = node
      end

      def organizational_unit_name
        @organizational_unit_name ||= @node.at('organizationalUnitName').inner_text
      end

      def organization_name
        @organization_name ||= @node.at('organizationName').inner_text
      end

      def business_category
        @business_category ||= @node.at('businessCategory').inner_text
      end

      def serial_number
        @serial_number ||= @node.at('serialNumber').inner_text.to_i
      end

      def common_name
        @common_name ||= @node.at('commonName').inner_text
      end

      def state_or_province_name
        @state_or_province_name ||= @node.at('stateOrProvinceName').inner_text
      end

      def country_name
        @country_name ||= @node.at('countryName').inner_text
      end

      def street_address
        @street_address ||= @node.at('streetAddress').inner_text
      end

      # TODO: oid-1.3.6.1.4.1.311.60.2.1.2
      # TODO: oid-1.3.6.1.4.1.311.60.2.1.3

      def locality_name
        @locality_name ||= @node.at('localityName').inner_text
      end

      def postal_code
        @postal_code ||= @node.at('postalCode').inner_text
      end

    end
  end
end

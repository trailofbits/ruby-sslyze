require 'sslyze/xml/certificate/domain_name'

module SSLyze
  class XML
    class Certificate
      #
      # Represents the `<subject>` XML element.
      #
      class Subject

        #
        # Initializes the subject.
        #
        # @param [Nokogiri::XML::Node] node
        #   The `<subject>` XML element.
        #
        def initialize(node)
          @node = node
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

        #
        # Business category.
        # 
        # @return [String]
        #
        def business_category
          @business_category ||= @node.at('businessCategory').inner_text
        end

        #
        # Serial number.
        #
        # @return [Integer]
        #
        def serial_number
          @serial_number ||= @node.at('serialNumber').inner_text.to_i
        end

        #
        # Common name.
        #
        # @return [DomainName]
        #
        def common_name
          @common_name ||= if (common_name = @node.at('commonName'))
                             DomainName.new(common_name.inner_text)
                           end
        end

        #
        # State/province name.
        #
        # @return [String]
        #
        def state_or_province_name
          @state_or_province_name ||= @node.at('stateOrProvinceName').inner_text
        end

        #
        # Country name.
        #
        # @return [String]
        #
        def country_name
          @country_name ||= @node.at('countryName').inner_text
        end

        #
        # Street address.
        #
        # @return [String]
        #
        def street_address
          @street_address ||= @node.at('streetAddress').inner_text
        end

        # TODO: oid-1.3.6.1.4.1.311.60.2.1.2
        # TODO: oid-1.3.6.1.4.1.311.60.2.1.3

        #
        # Locality name.
        #
        # @return [String]
        #
        def locality_name
          @locality_name ||= @node.at('localityName').inner_text
        end

        #
        # Postal code.
        #
        # @return [String]
        #
        def postal_code
          @postal_code ||= @node.at('postalCode').inner_text
        end

      end
    end
  end
end

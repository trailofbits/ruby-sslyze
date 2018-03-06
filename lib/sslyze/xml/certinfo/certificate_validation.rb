require 'sslyze/xml/plugin'
require 'sslyze/xml/certinfo/certificate_validation/hostname_validation'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<certificateValidation>` XML element.
      #
      # @since 1.0.0
      #
      class CertificateValidation

        #
        # Initializes the {CertificateValidation} object.
        #
        # @param [Nokogiri::XML::Element] node
        #   The `<certificateValidation>` XML element.
        #
        def initialize(node)
          @node = node
        end

        #
        # Hostname based validation information.
        #
        # @return [HostnameValidation]
        #
        def hostname_validation
          @hostname_validation ||= HostnameValidation.new(
            @node.at_xpath('hostnameValidation')
          )
        end

        alias hostname hostname_validation

        #
        # Enumerates over the path-based validation information.
        #
        # @yield [path_validation]
        #
        # @yieldparam [PathValidation] path_validation
        #
        # @return [Enumerator]
        #
        def each_path_validation
          return enum_for(__method__) unless block_given?

          @node.xpath('pathValidation').each do |element|
            yield PathValidation.new(element)
          end
        end

        #
        # @return [Array<PathValidation>]
        #
        # @see #each_path_validation
        #
        def path_validations
          each_path_validation.to_a
        end

        alias path path_validations

      end
    end
  end
end

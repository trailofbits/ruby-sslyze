require 'sslyze/xml/plugin'
require 'sslyze/xml/certinfo/certificate_validation/hostname_validation'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # Represents the `<certificateValidation />` XML element.
      #
      # @since 1.0.0
      #
      class CertificateValidation

        def initialize(node)
          @node = node
        end

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
        def path_validations
          each_path_validation.to_a
        end

      end
    end
  end
end

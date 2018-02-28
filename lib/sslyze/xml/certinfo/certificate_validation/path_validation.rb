require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/attributes/error'

module SSLyze
  class XML
    class Certinfo < Plugin
      class CertificateValidation
        #
        # Represents the `<pathValidation />` XML element.
        #
        # @since 1.0.0
        #
        class PathValidation

          include Types
          include Attributes::Error

          #
          # Initializes the element.
          #
          # @param [Nokogiri::XML::Element] node
          #
          def initialize(node)
            @node = node
          end

          #
          # @return [Boolean, nil]
          #
          def is_extended_validation_certificate?
            Boolean[@node['isExtendedValidationCertificate']]
          end

          alias is_extended_validation_cert? is_extended_validation_certificate?

          #
          # @return [String]
          #
          def trust_store_version
            @trust_store_version ||= @node['trustStoreVersion']
          end

          #
          # @return [String]
          #
          def using_trust_store
            @using_trust_store ||= @node['usingTrustStore']
          end

          alias trust_store using_trust_store

          #
          # The validation result.
          #
          # @return [Symbol, nil]
          #
          def validation_result
            @validation_result ||= if (value = @node['validationResult'])
                                     value.to_sym
                                   end
          end

          alias result validation_result

          #
          # Determines if the {#validation_result} was `:ok`.
          #
          # @return [Boolean, nil]
          #
          def ok?
            if validation_result
              validation_result == :ok
            end
          end

          alias valid? ok?

        end
      end
    end
  end
end

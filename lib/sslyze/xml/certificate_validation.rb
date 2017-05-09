require 'sslyze/xml/types'

module SSLyze
  class XML
    #
    # Represents the `<certificateValidation>` XML element.
    #
    class CertificateValidation

      include Types

      #
      # Initializes the certificate validation.
      #
      # @param [Nokogiri::XML::Node] node
      #   The `<certificateValidation>` XMl element.
      #
      def initialize(node)
        @node = node
      end

      #
      # Specifies whether the hostname was validated.
      #
      # @return [Boolean]
      #
      def hostname?
        Boolean[@node.at('hostnameValidation/@certificateMatchesServerHostname').value]
      end

      #
      # Retrieves the validation results for each trust store.
      #
      # @return [Hash{String => String}]
      #   The certificate store name and validation result.
      #
      # @since 0.2.0
      #
      def results
        @path ||= Hash[@node.search('pathValidation').map { |path|
          [path['usingTrustStore'], path['validationResult']]
        }]
      end

      #
      # Specifies whether the certificate path was validated against various
      # certificate stores.
      #
      # @return [Hash{String => Boolean}]
      #   The certificate store name and validation result.
      #
      def path
        @path ||= Hash[results.map { |trust_store,result|
          [trust_store, result == 'ok']
        }]
      end

      #
      # Determines whether the certificate was validated by all the certificate
      # stores.
      #
      # @return [Boolean]
      #
      # @since 0.2.0
      #
      def path?
        path.all? { |cert_store,trusted| trusted }
      end

    end
  end
end

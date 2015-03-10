require 'sslyze/types'

module SSLyze
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
    # Specifies whether the certificate path was validated against various
    # certificate stores.
    #
    # @return [Hash{String => Boolean}]
    #   The certificate store name and validation result.
    #
    def path
      @path ||= Hash[@node.search('pathValidation').map { |path|
        [path['usingTrustStore'], path['validationResult'] == 'ok']
      }]
    end

  end
end

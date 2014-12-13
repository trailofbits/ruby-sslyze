module SSLyze
  class CertificateValidation

    def initialize(node)
      @node = node
    end

    #
    # @return [Boolean]
    #
    def hostname?
      @node.at('hostnameValiation/@certificateMatchesServerHostname').value == 'True'
    end

    #
    # @return [Hash{String => Boolean}]
    #
    def path
      @path ||= Hash[@node.search('pathValidation').map { |path|
        [path['usingTrustStore'], path['validationResult'] == 'ok']
      }]
    end

  end
end

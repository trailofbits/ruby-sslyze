require 'sslyze/types'

module SSLyze
  class CertificateValidation

    include Types

    def initialize(node)
      @node = node
    end

    #
    # @return [Boolean]
    #
    def hostname?
      Boolean[@node.at('hostnameValidation/@certificateMatchesServerHostname').value]
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

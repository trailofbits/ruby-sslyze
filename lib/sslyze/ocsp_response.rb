require 'sslyze/types'

require 'time'

module SSLyze
  #
  # Represents the `<ocspStapling>` XML element.
  #
  class OCSPResponse

    include Types

    #
    # Initializes the OCSP response.
    #
    # @param [Nokogiri::XML::Node] node
    #   The `<ocspStapling>` XML element.
    #
    def initialize(node)
      @node = node
    end

    #
    # Specifies whether the response was trusted.
    #
    # @return [Boolean]
    #
    def trusted?
      Boolean[@node['isTrustedByMozillaCAStore']]
    end

    #
    # The response type.
    #
    # @return [String]
    #
    def type
      @type ||= @node.at('responseType').inner_text
    end

    #
    # The response ID.
    #
    # @return [String]
    #
    def id
      @id ||= @node.at('responseID').inner_text
    end

    #
    # The OCSP version.
    #
    # @return [Integer]
    #
    def version
      @version ||= @node.at('version').inner_text.to_i
    end

    #
    # The response status.
    #
    # @return [Symbol]
    #
    def status
      @status ||= @node.at('responseStatus').inner_text.to_sym
    end

    #
    # Determines whether the OCSP response was a success.
    #
    # @return [Boolean]
    #
    def successful?
      status == :successful
    end

    #
    # When the response was produced.
    #
    # @return [Time]
    #
    def produced_at
      @produced_at ||= Time.parse(@node.at('producedAt').inner_text)
    end

  end
end

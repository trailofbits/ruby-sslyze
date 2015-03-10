require 'sslyze/certificate/extensions/extension'

require 'uri'

module SSLyze
  class Certificate
    class Extensions
      #
      # Represents the `<AuthorityInformationAccess>` XML element.
      #
      class AuthorityInformationAccess < Extension

        #
        # The CA issuers.
        #
        # @return [Array<URI>]
        #
        def ca_issuers
          @ca_issuers ||= @node.search('CAIssuers/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

        #
        # The OCSP URIs.
        #
        # @return [Array<URI>]
        #
        def ocsp
          @ocsp ||= @node.search('OCSP/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

      end
    end
  end
end

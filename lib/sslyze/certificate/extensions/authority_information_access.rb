require 'sslyze/certificate/extensions/extension'

require 'uri'

module SSLyze
  class Certificate
    class Extensions
      class AuthorityInformationAccess < Extension

        def ca_issuers
          @ca_issuers ||= @node.search('CAIssuers/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

        def ocsp
          @ocsp ||= @node.search('OCSP/URI/listEntry').map do |uri|
            URI(uri.inner_text)
          end
        end

      end
    end
  end
end

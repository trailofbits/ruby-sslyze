require 'sslyze/xml/certificate/extensions/extension'

module SSLyze
  class XML
    class Certificate
      class Extensions
        #
        # Represents the `<X509v3CRLDistributionPoints>` XML element.
        #
        class X509v3CRLDistributionPoints < Extension

          #
          # @return [Array<String>]
          #
          def full_name
            @full_name ||= @node.search('FullName/listEntry').map do |full_name|
              full_name.inner_text
            end
          end

          #
          # @return [Array<URI>]
          #
          def uri
            @uri ||= @node.search('URI/listEntry').map do |uri|
              URI(uri.inner_text)
            end
          end

        end
      end
    end
  end
end

require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      #
      # Represents the `<X509v3CertificatePolicies>` XML element.
      #
      class X509v3CertificatePolicies < Extension

        #
        # The certificate policy.
        #
        # @return [Array<String>]
        #
        def policy
          @policy ||= @node.search('Policy/listEntry').map(&:inner_text)
        end

        #
        # The explicit text.
        #
        # @return [Array<String>]
        #
        def explicit_text
          @explicit_text ||= @node.search('ExplicitText/listEntry').map(&:inner_text)
        end

        #
        # The CPS.
        #
        # @return [Array<String>]
        #
        def cps
          @cps ||= @node.search('CPS/listEntry').map(&:inner_text)
        end

        #
        # User notice.
        #
        # @return [String, nil]
        #
        def user_notice
          @user_notice ||= @node.search('userNotice/listEntry').map(&:inner_text)
        end

      end
    end
  end
end

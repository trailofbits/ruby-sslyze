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
        # @return [String]
        #
        def policy
          @policy ||= @node.at('Policy/listEntry').inner_text
        end

        #
        # The explicit text.
        #
        # @return [String, nil]
        #
        def explicit_text
          @explicit_text ||= if (explicit_text = @node.at('ExplicitText/listEntry'))
                               explicit_text.inner_text
                             end
        end

        #
        # The CPS.
        #
        # @return [String]
        #
        def cps
          @cps ||= @node.at('CPS/listEntry').inner_text
        end

        #
        # User notice.
        #
        # @return [String, nil]
        #
        def user_notice
          @user_notice ||= if (user_notice = @node.at('userNotice/listEntry'))
                             user_notice.inner_text
                           end
        end

      end
    end
  end
end

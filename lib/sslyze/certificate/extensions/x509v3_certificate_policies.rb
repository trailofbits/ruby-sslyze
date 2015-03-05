require 'sslyze/certificate/extensions/extension'

module SSLyze
  class Certificate
    class Extensions
      class X509v3CertificatePolicies < Extension

        def policy
          @policy ||= @node.at('Policy/listEntry').inner_text
        end

        def explicit_text
          @explicit_text ||= if (explicit_text = @node.at('ExplicitText/listEntry'))
                               explicit_text.inner_text
                             end
        end

        def cps
          @cps ||= @node.at('CPS/listEntry').inner_text
        end

        def user_notice
          @user_notice ||= if (user_notice = @node.at('userNotice/listEntry'))
                             user_notice.inner_text
                           end
        end

      end
    end
  end
end

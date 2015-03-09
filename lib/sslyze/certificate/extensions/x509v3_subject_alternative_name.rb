require 'sslyze/certificate/extensions/x509v3_subject_alternative_name'

module SSLyze
  class Certificate
    class Extensions
      class X509v3SubjectAlternativeName < Extension

        #
        # The alternative email names.
        #
        # @return [Array<String>]
        #
        def email
          @email ||= @node.search('email/listEntry').map(&:inner_text)
        end

        #
        # The alternative URI names.
        #
        # @return [Array<String>]
        #
        def uri
          @rui ||= @node.search('URI/listEntry').map(&:inner_text)
        end

        #
        # The alternative DNS names.
        #
        # @return [Array<String>]
        #
        def dns
          @dns ||= @node.search('DNS/listEntry').map(&:inner_text)
        end

        #
        # The alternative RID names.
        #
        # @return [Array<String>]
        #
        def rid
          @rid ||= @node.search('RID/listEntry').map(&:inner_text)
        end

        #
        # The alternative IP names.
        #
        # @return [Array<String>]
        #
        def ip
          @ip ||= @node.search('IP/listEntry').map(&:inner_text)
        end

        #
        # The alternative dirName names.
        #
        # @return [Array<String>]
        #
        def dir_name
          @dir_name ||= @node.search('dirName/listEntry').map(&:inner_text)
        end

      end
    end
  end
end

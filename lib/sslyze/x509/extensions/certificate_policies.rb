require 'sslyze/x509/extension'

require 'uri'

module SSLyze
  module X509
    module Extensions
      class CertificatePolicies < Extension

        class Policy

          attr_reader :policy

          attr_reader :cps

          attr_reader :user_notice

          #
          # Initializes the policy.
          #
          # @param [String] policy
          #   The policy text.
          #
          # @param [Hash{Symbol => Object}] qualifiers
          #
          # @option qualifiers [URI, String, nil] :cps
          #   The CPS URI.
          #
          # @option qualifiers [String, nil] :user_notice
          #   The user notice.
          #
          def initialize(policy,qualifiers={})
            @policy = policy

            @cps         = URI(cps) if cps
            @user_notice = user_notice
          end

          alias to_uri cps
          alias to_s policy

        end

        include Enumerable

        #
        # Parses the individual policies listed in the extension's value.
        #
        # @return [Array<Policy>]
        #
        def policies
          # XXX: ugly multiline regexp to parse the certificate policies and
          # their qualifiers.
          @policies ||= value.scan(/^Policy: ([^\n]+)\n(?:  CPS: ([^\n]+)\n)?(?:  User Notice: ([^\n]+)\n)?(?:Unknown Qualifier: [^\n]+\n)?/m).map do |(policy,cps,user_notice)|
            Policy.new(policy, cps: cps, user_notice: user_notice)
          end
        end

        #
        # The number of certificate policies.
        #
        # @return [Integer]
        #
        def length
          policies.length
        end

        #
        # Enumerates over every certificate policy in the extension.
        #
        # @yield [policy]
        #   The given block will be passed each parsed policy.
        #
        # @yieldparam [Policy] policy
        #   A parsed certificate policy.
        #
        # @return [Enumerator]
        #   If no block is given, an Enumerator will be returned.
        #
        def each(&block)
          policies.each(&block)
        end

      end
    end
  end
end

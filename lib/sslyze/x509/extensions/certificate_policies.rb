require 'sslyze/x509/extension'

require 'uri'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `certificatePolicies` X509v3 extension.
      #
      # @since 1.0.0
      #
      class CertificatePolicies < Extension

        #
        # Represents an individual certificate policy.
        #
        class Policy

          # @return [String]
          attr_reader :policy

          # @return [URI::Generic, nil]
          attr_reader :cps

          # @return [String, nil]
          attr_reader :user_notice

          #
          # Initializes the policy.
          #
          # @param [String] policy
          #   The policy text.
          #
          # @param [Hash{Symbol => Object}] qualifiers
          #
          # @option qualifiers [URI::Generic, nil] :cps
          #   The CPS URI.
          #
          # @option qualifiers [String, nil] :user_notice
          #   The user notice.
          #
          def initialize(policy,qualifiers={})
            @policy = policy

            @cps         = qualifiers[:cps]
            @user_notice = qualifiers[:user_notice]
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
          @policies ||= value.scan(/^Policy: [^\n]+\n(?:  [^:]+: [^\n]+\n)*/m).map do |text|
            policy = text.match(/^Policy: ([^\n]+)/)[1]

            cps = if (match = text.match(/^  CPS: ([^\n]+)/m))
                    URI.parse(match[1])
                  end

            user_notice = if (match = text.match(/^  User Notice: ([^\n]+)/m))
                            match[1]
                          end

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

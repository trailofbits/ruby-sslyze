require 'sslyze/x509/extension'

module SSLyze
  module X509
    module Extensions
      #
      # Represents the `keyUsage` X509v3 extension.
      #
      # @since 1.0.0
      #
      class KeyUsage < Extension

        include Enumerable

        #
        # The various permitted key uses.
        #
        # @return [Array<String>]
        #
        def uses
          @uses ||= value.split(', ')
        end

        #
        # @yield [use]
        #
        # @yieldparam [String] use
        #
        # @return [Enumerator]
        #
        def each(&block)
          uses.each(&block)
        end

        #
        # @return [Boolean]
        #
        def key_encipherment?
          uses.include?('Key Encipherment')
        end

        #
        # @return [Boolean]
        #
        def digital_signature?
          uses.include?('Digital Signature')
        end

        #
        # @return [Boolean]
        #
        def crl_sign?
          uses.include?('CRL Sign')
        end

        #
        # @return [Boolean]
        #
        def certificate_sign?
          uses.include?('Certificate Sign')
        end

      end
    end
  end
end

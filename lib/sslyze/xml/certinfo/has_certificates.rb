require 'sslyze/xml/plugin'
require 'sslyze/xml/types'
require 'sslyze/xml/certinfo/certificate'

module SSLyze
  class XML
    class Certinfo < Plugin
      #
      # @since 1.0.0
      #
      module HasCertificates
        include Enumerable

        #
        # Enumerates over each certificate in the chain.
        #
        # @yield [cert]
        #   The given block will be passed each certificate.
        #
        # @yieldparam [Certificate] cert
        #   A certificate in the chain.
        #
        # @return [Enumerator]
        #   If no block was given, an Enumerator will be returned.
        #
        def each_certificate
          return enum_for(__method__) unless block_given?

          @node.search('certificate').each do |element|
            yield Certificate.new(element)
          end
        end

        alias each_cert each_certificate
        alias each each_certificate

        #
        # Returns all certificates in the chain.
        #
        # @return [Array<Certificate>]
        #
        def certificates
          each_certificate.to_a
        end

        alias certs certificates

      end
    end
  end
end

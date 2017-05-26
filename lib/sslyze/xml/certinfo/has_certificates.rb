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

        #
        # The leaf certificate.
        #
        # @return [Certificate, nil]
        #
        def leaf
          if (element = @node.at('certificate[1]'))
            Certificate.new(element)
          end
        end

        #
        # Enumerates over any intermediate certificates in the chain.
        #
        # @yield [cert]
        #   The given block will be passed each intermediate certificate.
        #
        # @yieldparam [Certificate] cert
        #   An intermediate certificate in the chain.
        #
        # @return [Enumerator]
        #   If no block was given, an Enumerator will be returned.
        #
        def each_intermediate
          return enum_for(__method__) unless block_given?

          @node.search('certificate[position() > 1 and position() < last()]').each do |element|
            yield Certificate.new(element)
          end
        end

        #
        # Returns all intermediate certificates in the chain.
        #
        # @return [Array<Certificate>]
        #
        def intermediates
          each_intermediate.to_a
        end

        #
        # The root certificate.
        #
        # @return [Certificate, nil]
        #
        def root
          if (element = @node.at('certificate[last()]'))
            Certificate.new(element)
          end
        end

      end
    end
  end
end

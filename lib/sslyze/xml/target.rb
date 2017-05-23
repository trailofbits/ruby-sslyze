require 'sslyze/xml/types'
require 'sslyze/xml/certinfo'
require 'sslyze/xml/compression'
require 'sslyze/xml/heartbleed'
require 'sslyze/xml/http_headers'
require 'sslyze/xml/reneg'
require 'sslyze/xml/resum'
require 'sslyze/xml/resum_rate'
require 'sslyze/xml/protocol'
require 'sslyze/xml/fallback'
require 'sslyze/xml/openssl_ccs'

require 'ipaddr'

module SSLyze
  class XML
    #
    # Represents the `<target>` XML element.
    #
    class Target

      include Types

      #
      # Initializes the target.
      #
      # @param [Nokogiri::XML::Node] node
      #   The `<target>` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The host name of the target.
      #
      # @return [String]
      #
      def host
        @host ||= @node['host']
      end

      #
      # The IP address of the target.
      #
      # @return [String]
      #
      def ip
        @ip ||= @node['ip']
      end

      #
      # The IP address of the target.
      # 
      # @return [IPAddr]
      #
      # @since 1.0.0
      #
      def ipaddr
        IPAddr.new(ip)
      end

      #
      # The port number that was scanned.
      #
      # @return [Integer]
      #
      def port
        @port ||= @node['port'].to_i
      end

      #
      # Which compression algorithms are supported.
      #
      # @return [Compression, nil]
      #
      def compression
        @compression ||= if (element = @node.at('compression'))
                           Compression.new(element)
                         end
      end

      #
      # Certificate information.
      #
      # @return [Certinfo, nil]
      #
      # @since 1.0.0
      #
      def certinfo
        @cert_info ||= if (element = @node.at('certinfo'))
                         Certinfo.new(element)
                       end
      end

      #
      # @return [Heartbleed, nil]
      #
      # @since 1.0.0
      #
      def heartbleed
        @heartbleed ||= if (element = @node.at('heartbleed'))
                          Heartbleed.new(element)
                        end
      end

      #
      # @return [HTTPHeaders, nil]
      #
      # @since 1.0.0
      #
      def http_headers
        @http_headers ||= if (element = @node.at('http_headers'))
                            HTTPHeaders.new(element)
                          end
      end

      #
      # Specifies whether the service supports Session Renegotiation.
      #
      # @return [Reneg, nil]
      #
      # @since 1.0.0
      # 
      def reneg
        @reneg ||= if (element = @node.at('reneg'))
                     Reneg.new(element)
                   end
      end

      alias session_renegotiation reneg

      #
      # @return [Resum, nil]
      #
      # @since 1.0.0
      #
      def resum
        @resum ||= if (element = @node.at('resum'))
                     Resum.new(element)
                   end
      end

      alias session_resumption resum

      #
      # @return [Resum, nil]
      #
      # @since 1.0.0
      #
      def resum_rate
        @resum ||= if (element = @node.at('resum_rate'))
                     ResumRate.new(element)
                   end
      end

      alias session_resumption resum_rate

      #
      # SSLv2 protocol information.
      #
      # @return [Protocol, nil]
      #
      def sslv2
        @sslv2 ||= if (element = @node.at('sslv2'))
                     Protocol.new(element)
                   end
      end

      alias ssl_v2 sslv2

      #
      # SSLv3 protocol information.
      #
      # @return [Protocol, nil]
      #
      def sslv3
        @sslv3 ||= if (element = @node.at('sslv3'))
                     Protocol.new(element)
                   end
      end

      alias ssl_v3 sslv3

      #
      # TLSv1 protocol information.
      #
      # @return [Protocol, nil]
      #
      def tlsv1
        @tlsv1 ||= if (element = @node.at('tlsv1'))
                     Protocol.new(element)
                   end
      end

      alias tls_v1 tlsv1

      #
      # TLSv1.1 protocol information.
      #
      # @return [Protocol, nil]
      #
      def tlsv1_1
        @tlsv1_1 ||= if (element = @node.at('tlsv1_1'))
                       Protocol.new(element)
                     end
      end

      alias tls_v1_1 tlsv1_1

      #
      # TLSv1.2 protocol information.
      #
      # @return [Protocol, nil]
      #
      def tlsv1_2
        @tlsv1_2 ||= if (element = @node.at('tlsv1_2'))
                       Protocol.new(element)
                     end
      end

      alias tls_v1_2 tlsv1_2

      #
      # Iterates over every SSL protocol.
      #
      # @yield [protocol]
      #   The given block will be passed each SSL protocol.
      #
      # @yieldparam [Protocol] protocol
      #   A SSL protocol.
      #
      # @return [Enumerator]
      #   If a no block was given, an Enumerator will be returned.
      #
      # @see #sslv2
      # @see #sslv3
      #
      def each_ssl_protocol
        return enum_for(__method__) unless block_given?

        yield sslv2 if sslv2
        yield sslv3 if sslv3
      end

      #
      # All supported SSL protocols.
      #
      # @return [Array<Protocol>]
      #
      def ssl_protocols
        each_ssl_protocol.to_a
      end

      #
      # Iterates over every TLS protocol.
      #
      # @yield [protocol]
      #   The given block will be passed each TLS protocol.
      #
      # @yieldparam [Protocol] protocol
      #   A TLS protocol.
      #
      # @return [Enumerator]
      #   If a no block was given, an Enumerator will be returned.
      #
      # @see #tlsv1
      # @see #tlsv1_1
      # @see #tlsv1_2
      #
      def each_tls_protocol
        return enum_for(__method__) unless block_given?

        yield tlsv1 if tlsv1
        yield tlsv1_1 if tlsv1_1
        yield tlsv1_2 if tlsv1_2
      end

      #
      # All supported TLS protocols.
      #
      # @return [Array<Protocol>]
      #
      def tls_protocols
        each_tls_protocol.to_a
      end

      #
      # Iterates over every SSL/TLS protocol.
      #
      # @yield [protocol]
      #   The given block will be passed each SSL/TLS protocol.
      #
      # @yieldparam [Protocol] protocol
      #   A SSL/TLS protocol.
      #
      # @return [Enumerator]
      #   If a no block was given, an Enumerator will be returned.
      #
      # @see #sslv2
      # @see #sslv3
      # @see #tlsv1
      # @see #tlsv1_1
      # @see #tlsv1_2
      #
      def each_protocol(&block)
        return enum_for(__method__) unless block

        each_ssl_protocol(&block)
        each_tls_protocol(&block)
      end

      #
      # All supported SSL/TLS protocols.
      #
      # @return [Array<Protocol>]
      #
      def protocols
        each_protocol.to_a
      end

      #
      # @return [Fallback, nil]
      #
      # @since 1.0.0
      #
      def fallback
        @fallback ||= if (element = @node.at('fallback'))
                        Fallback.new(element)
                      end
      end

      #
      # @return [OpenSSLCCS, nil]
      #
      # @since 1.0.0
      #
      def openssl_ccs
        @openssl_ccs ||= if (element = @node.at('openssl_ccs'))
                           OpenSSLCCS.new(element)
                         end
      end

      #
      # Convert the target to a String.
      #
      # @return [String]
      #   The host and port.
      #
      def to_s
        "#{host}:#{port}"
      end

      #
      # Compares the other target to this target.
      #
      # @param [Target] other
      #   The other target.
      #
      # @return [Boolean]
      #   Whether the other target has the same host and port.
      #
      def ==(other)
        other.kind_of?(self.class) && other.host == host && other.port == port
      end

    end
  end
end

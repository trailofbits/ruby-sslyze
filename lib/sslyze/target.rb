require 'sslyze/types'
require 'sslyze/cert_info'
require 'sslyze/protocol'

module SSLyze
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
    # The port number that was scanned.
    #
    # @return [Integer]
    #
    def port
      @port ||= @node['port'].to_i
    end

    #
    # Certificate information.
    #
    # @return [CertInfo, nil]
    #
    def cert_info
      @cert_info ||= if (certinfo = @node.at('certinfo'))
                       CertInfo.new(certinfo)
                     end
    end

    #
    # Which compression algorithms are supported.
    #
    # @return [Hash{Symbol => Boolean}]
    #   The algorithm name and support status.
    #
    def compression
      unless @compression
        @compression = {}

        @node.search('compression/compressionMethod').map do |compression|
          type      = compression['type'].downcase.to_sym
          supported = Boolean[compression['isSupported']]

          @compression[type] = supported
        end
      end

      return @compression
    end

    #
    # Specifies whether the service was vulnerable to Heartbleed.
    #
    # @return [Boolean, nil]
    #
    def heartbleed?
      if (heartbleed = @node.at('heartbleed/openSslHeartbleed'))
        Boolean[heartbleed['isVulnerable']]
      end
    end

    #
    # Represents the `<sessionRenegotiation>` XML element.
    #
    class SessionRenegotiation < Struct.new(:client_initiated, :secure)

      def client_initiated?
        client_initiated == true
      end

      def secure?
        secure == true
      end

    end

    #
    # Specifies whether the service supports Session Renegotiation.
    #
    # @return [SessionRenegotiation, nil]
    # 
    def session_renegotiation
      @session_renegotiation ||= (
        if (sessionRenegotiation = @node.at('reneg/sessionRenegotiation'))

          SessionRenegotiation.new(
            Boolean[sessionRenegotiation['canBeClientInitiated']],
            Boolean[sessionRenegotiation['isSecure']]
          )
        end
      )
    end

    #
    # SSLv2 protocol information.
    #
    # @return [Protocol, nil]
    #
    def sslv2
      @sslv2 ||= if (node = @node.at('sslv2'))
                   Protocol.new(node)
                 end
    end

    alias ssl_v2 sslv2

    #
    # SSLv3 protocol information.
    #
    # @return [Protocol, nil]
    #
    def sslv3
      @sslv3 ||= if (node = @node.at('sslv3'))
                   Protocol.new(node)
                 end
    end

    #
    # TLSv1 protocol information.
    #
    # @return [Protocol, nil]
    #
    def tlsv1
      @tlsv1 ||= if (node = @node.at('tlsv1'))
                   Protocol.new(node)
                 end
    end

    alias tls_v1 tlsv1

    #
    # TLSv1.1 protocol information.
    #
    # @return [Protocol, nil]
    #
    def tlsv1_1
      @tlsv1_1 ||= if (node = @node.at('tlsv1_1'))
                     Protocol.new(node)
                   end
    end

    alias tls_v1_1 tlsv1_1

    #
    # TLSv1.2 protocol information.
    #
    # @return [Protocol, nil]
    #
    def tlsv1_2
      @tlsv1_2 ||= if (node = @node.at('tlsv1_2'))
                     Protocol.new(node)
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
    # @see {#sslv2}, {#sslv3}
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
    # @see {#tlsv1}, {#tlsv1_1}, {#tlsv1_2}
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
    # @see {#sslv2}, {#sslv3}, {#tlsv1}, {#tlsv1_1}, {#tlsv1_2}
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

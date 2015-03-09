require 'sslyze/types'
require 'sslyze/cert_info'
require 'sslyze/protocol'

module SSLyze
  class Target

    include Types

    def initialize(node)
      @node = node
    end

    def host
      @host ||= @node['host']
    end

    def ip
      @ip ||= @node['ip']
    end

    def port
      @port ||= @node['port'].to_i
    end

    def cert_info
      @cert_info ||= CertInfo.new(@node.at('certinfo'))
    end

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

    def heartbleed?
      if (heartbleed = @node.at('heartbleed/heartbleed'))
        Boolean[heartbleed['isVulnerable']]
      end
    end

    class SessionRenegotiation < Struct.new(:client_initiated, :secure)

      def client_initiated?
        client_initiated == true
      end

      def secure?
        secure == true
      end

    end

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

    def sslv2
      @sslv2 ||= if (node = @node.at('sslv2'))
                   Protocol.new(node)
                 end
    end

    def sslv3
      @sslv3 ||= if (node = @node.at('sslv3'))
                   Protocol.new(node)
                 end
    end

    def tlsv1
      @tlsv1 ||= if (node = @node.at('tlsv1'))
                   Protocol.new(node)
                 end
    end

    def tlsv1_1
      @tlsv1_1 ||= if (node = @node.at('tlsv1_1'))
                     Protocol.new(node)
                   end
    end

    def tlsv1_2
      @tlsv1_2 ||= if (node = @node.at('tlsv1_2'))
                     Protocol.new(node)
                   end
    end

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

  end
end

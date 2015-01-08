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

  end
end

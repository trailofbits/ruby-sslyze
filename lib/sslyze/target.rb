module SSLyze
  class Target

    BOOLEAN = {
      'True' => true,
      'False' => false
    }

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
        @node.search('compression/compressionMethod').map do |compression|
          type      = compression['type'].downcase.to_sym
          supported = BOOLEAN[compression['isSupported']]

          @compression[type] = supported
        end
      end

      return @compression
    end

    def heartbleed?
      @heartbleed ||= BOOLEAN[@node.at('heartbleed/heartbleed/@isVulnerable')]
    end

    def sslv2
      @sslv2 ||= CipherSuite.new(@node.at('sslv2'))
    end

    def sslv3
      @sslv3 ||= CipherSuite.new(@node.at('sslv3'))
    end

    def tlsv1
      @tlsv1 ||= CipherSuite.new(@node.at('tlsv1'))
    end

    def tlsv1_1
      @tlsv1_1 ||= CipherSuite.new(@node.at('tlsv1_1'))
    end

    def tlsv1_2
      @tlsv1_2 ||= CipherSuite.new(@node.at('tlsv1_2'))
    end

  end
end

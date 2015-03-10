require 'rprogram/task'

module SSLyze
  #
  # Represents options for {Program}.
  #
  class Task < RProgram::Task

    # Options:
    long_option flag: '--version'
    long_option flag: '--help'
    long_option flag: '--xml_out'
    long_option flag: '--targets_in'
    long_option flag: '--timeout'
    long_option flag: '--nb_retries'
    long_option flag: '--https_tunnel'
    long_option flag: '--starttls'
    long_option flag: '--xmpp_to'
    long_option flag: '--sni'
    long_option flag: '--regular'

    # Client certificate support:
    long_option flag: '--cert'
    long_option flag: '--certfrom'
    long_option flag: '--key'
    long_option flag: '--keyfrom'
    long_option flag: '--pass'

    # PluginHeartbleed:
    long_option flag: '--heartbleed'

    # PluginOpenSSLCipherSuites:
    #   Scans the server(s) for supported OpenSSL cipher suites.
    long_option flag: '--sslv2'
    long_option flag: '--sslv3'
    long_option flag: '--tlsv1'
    long_option flag: '--tlsv1_1'
    long_option flag: '--tlsv1_2'
    long_option flag: '--http_get'
    long_option flag: '--hide_rejected_ciphers'

    # PluginSessionRenegotiation:
    long_option flag: '--reneg'

    # PluginCertInfo:
    long_option flag: '--certinfo'

    # PluginHSTS:
    long_option flag: '--hsts'

    # PluginSessionResumption:
    #   Analyzes the target server's SSL session resumption capabilities.
    long_option flag: '--resum'
    long_option flag: '--resum_rate'

    # PluginChromeSha1Deprecation:
    long_option flag: '--chrome_sha1'

    # PluginCompression:
    long_option flag: '--compression'

    non_option name: :targets, tailing: true

  end
end

require 'rprogram/task'

module SSLyze
  #
  # Represents options for {Program}.
  #
  class Task < RProgram::Task

    # Options:
    long_option flag: '--version'
    long_option flag: '--help'
    long_option flag: '--regular'

    # Client certificate support:
    long_option flag: '--cert', equals: true
    long_option flag: '--key', equals: true
    long_option flag: '--keyform', equals: true
    long_option flag: '--pass', equals: true

    # Input and output options:
    long_option flag: '--xml_out', equals: true
    long_option flag: '--json_out', equals: true
    long_option flag: '--targets_in', equals: true
    long_option flag: '--quiet'

    # Connectivity options:
    long_option flag: '--slow_connection'
    long_option flag: '--https_tunnel', equals: true
    long_option flag: '--starttls', equals: true
    long_option flag: '--xmpp_to', equals: true
    long_option flag: '--sni', equals: true

    # HeartbleedPlugin:
    long_option flag: '--heartbleed'

    # OpenSslCcsInjectionPlugin:
    long_option flag: '--openssl_ccs'

    # FallbackScsvPlugin:
    long_option flag: '--fallback'

    # SessionRenegotiationPlugin:
    long_option flag: '--reneg'

    # CertificateInfoPlugin:
    long_option flag: '--certinfo'
    long_option flag: '--ca_file', equals: true

    # HttpHeadersPlugin:
    long_option flag: '--http_headers'

    # SessionResumptionPlugin:
    long_option flag: '--resum'
    long_option flag: '--resum_rate'

    # CompressionPlugin:
    long_option flag: '--compression'

    # OpenSslCipherSuitesPlugin:
    long_option flag: '--sslv2'
    long_option flag: '--sslv3'
    long_option flag: '--tlsv1'
    long_option flag: '--tlsv1_1'
    long_option flag: '--tlsv1_2'
    long_option flag: '--http_get'
    long_option flag: '--hide_rejected_ciphers'

    non_option name: :targets, tailing: true

  end
end

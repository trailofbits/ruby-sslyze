require 'delegate'

module SSLyze
  module X509
    #
    # Wraps around an [OpenSSL::X509::Extension][1] object.
    #
    # @see http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension
    #
    # @since 1.0.0
    #
    class Extension < SimpleDelegator
    end
  end
end

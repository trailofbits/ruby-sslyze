module SSLyze
  module X509
    #
    # Provides a Hash-like interface around an Array of
    # [OpenSSL::X5095::Extension][1]s.
    #
    # [1]: http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension
    #
    class ExtensionSet

      include Enumerable

      #
      # Initializes the X509 extension set.
      #
      # @param [Array<OpenSSL::X509::Extension>] extensions
      #   The array of extensions.
      #
      def initialize(extensions)
        @extensions = Hash[extensions.map { |ext|
          [ext.oid, ext]
        }]
      end

      #
      # Enumerates over the X509 extensions in the set.
      #
      # @yield [extension]
      #
      # @yieldparam [OpenSSL::X509::Extension] extension
      #
      # @return [Enumerator]
      #
      def each(&block)
        @extensions.each_value(&block)
      end

      #
      # Determines if the X509 extension exists in the set.
      #
      # @param [String] oid
      #
      # @return [Boolean]
      #
      def has?(oid)
        @extensions.has_key?(oid)
      end

      #
      # Looks up the X509 extension with the given name.
      # @param [String] oid
      #
      # @return [OpenSSL::X509::Extension]
      #
      def [](oid)
        @extensions[oid]
      end

      #
      # Converts the X509 extension set to an Array.
      #
      # @return [Array<OpenSSL::X509::Extension>]
      #
      def to_a
        @extensions.values
      end

    end
  end
end

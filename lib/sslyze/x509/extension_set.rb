require 'sslyze/x509/extensions'

module SSLyze
  module X509
    #
    # Provides a Hash-like interface around an Array of
    # [OpenSSL::X5095::Extension][1]s.
    #
    # [1]: http://www.rubydoc.info/stdlib/openssl/OpenSSL/X509/Extension
    #
    # @since 1.0.0
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

      #
      # The `basicConstraints` extension.
      #
      # @return [Extensions::BasicConstraints, nil]
      #
      def basic_constraints
        @basic_constraints ||= if (ext = self['basicConstraints'])
                                 Extensions::BasicConstraints.new(ext)
                               end
      end

      #
      # The `certificatePolicies` extension.
      #
      # @return [Extensions::CertificatePolicies, nil]
      #
      def certificate_policies
        @certificate_policies ||= if (ext = self['certificatePolicies'])
                                    Extensions::CertificatePolicies.new(ext)
                                  end
      end

      #
      # The `crlDistributionPoints` extension.
      #
      # @return [Extensions::CRLDistributionPoints, nil]
      #
      def crl_distribution_points
        @crl_distribution_points ||= if (ext = self['crlDistributionPoints'])
                                       Extensions::CRLDistributionPoints.new(ext)
                                     end
      end

      #
      # The `extendedKeyUsage` extension.
      #
      # @return [Extensions::ExtendedKeyUsage, nil]
      #
      def extended_key_usage
        @extended_key_usage ||= if (ext = self['extendedKeyUsage'])
                                  Extensions::ExtendedKeyUsage.new(ext)
                                end
      end

      #
      # The `keyUsage` extension.
      #
      # @return [Extensions::KeyUsage, nil]
      #
      def key_usage
        @key_usage ||= if (ext = self['keyUsage'])
                         Extensions::KeyUsage.new(ext)
                       end
      end

      #
      # The `subjectAltName` extension.
      #
      # @return [Extensions::SubjectAltName, nil]
      #
      def subject_alt_name
        @subject_alt_name ||= if (ext = self['subjectAltName'])
                                Extensions::SubjectAltName.new(ext)
                              end
      end

    end
  end
end

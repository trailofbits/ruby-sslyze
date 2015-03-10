require 'sslyze/certificate/extensions/authority_information_access'
require 'sslyze/certificate/extensions/x509v3_crl_distribution_points'
require 'sslyze/certificate/extensions/x509v3_key_usage'
require 'sslyze/certificate/extensions/x509v3_extended_key_usage'
require 'sslyze/certificate/extensions/x509v3_subject_alternative_name'
require 'sslyze/certificate/extensions/x509v3_basic_constraints'
require 'sslyze/certificate/extensions/x509v3_certificate_policies'

module SSLyze
  class Certificate
    #
    # Represents the `<extensions>` XML element.
    #
    class Extensions

      #
      # Initializes the extensions.
      #
      # @param [Nokogiri::XML::Node] node
      #   The `<extensions>` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # The x509v3 subject key identifier information.
      #
      # @return [String, nil]
      #
      def x509v3_subject_key_identifier
        @x509v3_subject_key_identifier ||= if (node = @node.at('X509v3SubjectKeyIdentifier'))
                                             node.inner_text
                                           end
      end

      #
      # The authority information access.
      #
      # @return [AuthorityInformationAccess, nil]
      #
      def authority_information_access
        @authority_information_access ||= if (node = @node.at('AuthorityInformationAccess'))
                                            AuthorityInformationAccess.new(node)
                                          end
      end

      #
      # The x509v3 CRL Distribution Points.
      #
      # @return [X509v3CRLDistributionPoints, nil]
      #
      def x509v3_crl_distribution_points
        @x509v3_crl_distribution_points ||= if (node = @node.at('X509v3CRLDistributionPoints'))
                                              X509v3CRLDistributionPoints.new(node)
                                            end
      end

      #
      # The x509v3 basic constraints.
      #
      # @return [X509v3BasicConstraints, nil]
      #
      def x509v3_basic_constraints
        @x509v3_basic_constraints ||= if (constraints = @node.at('X509v3BasicConstraints'))
                                        X509v3BasicConstraints.new(constraints)
                                      end
      end

      #
      # x509v3 key usage.
      #
      # @return [X509v3KeyUsage, nil]
      #
      def x509v3_key_usage
        @x509v3_key_usage ||= if (node = @node.at('X509v3KeyUsage'))
                                X509v3KeyUsage.new(node)
                              end
      end

      #
      # x509v3 extended key usage.
      #
      # @return [X509v3ExtendedKeyUsage, nil]
      #
      def x509v3_extended_key_usage
        @x509v3_extended_key_usage ||= if (node = @node.at('X509v3ExtendedKeyUsage'))
                                         X509v3ExtendedKeyUsage.new(node)
                                       end
      end

      #
      # x509v3 subject alternative name.
      #
      # @return [X509v3SubjectAlternativeName, nil]
      #
      def x509v3_subject_alternative_name
        @x509v3_subject_alternative_name ||= if (node = @node.search('X509v3SubjectAlternativeName'))
                                               X509v3SubjectAlternativeName.new(node)
                                             end
      end

      #
      # x509v3 authority key identifier.
      #
      # @return [String, nil]
      #
      def x509v3_authority_key_identifier
        @x509v3_authority_key_identifier ||= if (node = @node.at('X509v3AuthorityKeyIdentifier'))
                                               node.inner_text
                                             end
      end

      #
      # x509v3 certificate policies.
      #
      # @return [X509v3CertificatePolicies, nil]
      #
      def x509v3_certificate_policies
        @x509v3_certificate_policies ||= if (node = @node.at('X509v3CertificatePolicies'))
                                           X509v3CertificatePolicies.new(node)
                                         end
      end

    end
  end
end

require 'sslyze/certificate/extensions/authority_information_access'
require 'sslyze/certificate/extensions/x509v3_crl_distribution_points'
require 'sslyze/certificate/extensions/x509v3_key_usage'
require 'sslyze/certificate/extensions/x509v3_extended_key_usage'
require 'sslyze/certificate/extensions/x509v3_subject_alternative_name'
require 'sslyze/certificate/extensions/x509v3_basic_constraints'
require 'sslyze/certificate/extensions/x509v3_certificate_policies'

module SSLyze
  class Certificate
    class Extensions

      def initialize(node)
        @node = node
      end

      def x509v3_subject_key_identifier
        @x509v3_subject_key_identifier ||= if (node = @node.at('X509v3SubjectKeyIdentifier'))
                                             node.inner_text
                                           end
      end

      def authority_information_access
        @authority_information_access ||= if (node = @node.at('AuthorityInformationAccess'))
                                            AuthorityInformationAccess.new(node)
                                          end
      end

      def x509v3_crl_distribution_points
        @x509v3_crl_distribution_points ||= if (node = @node.at('X509v3CRLDistributionPoints'))
                                              X509v3CRLDistributionPoints.new(node)
                                            end
      end

      def x509v3_basic_constraints
        @x509v3_basic_constraints ||= if (constraints = @node.at('X509v3BasicConstraints'))
                                        X509v3BasicConstraints.new(constraints)
                                      end
      end

      def x509v3_key_usage
        @x509v3_key_usage ||= if (node = @node.at('X509v3KeyUsage'))
                                X509v3KeyUsage.new(node)
                              end
      end

      def x509v3_extended_key_usage
        @x509v3_extended_key_usage ||= if (node = @node.at('X509v3ExtendedKeyUsage'))
                                         X509v3ExtendedKeyUsage.new(node)
                                       end
      end

      def x509v3_subject_alternative_name
        @x509v3_subject_alternative_name ||= if (node = @node.search('X509v3SubjectAlternativeName'))
                                               X509v3SubjectAlternativeName.new(node)
                                             end
      end

      def x509v3_authority_key_identifier
        @x509v3_authority_key_identifier ||= if (node = @node.at('X509v3AuthorityKeyIdentifier'))
                                               node.inner_text
                                             end
      end

      def x509v3_certificate_policies
        @x509v3_certificate_policies ||= if (node = @node.at('X509v3CertificatePolicies'))
                                           X509v3CertificatePolicies.new(node)
                                         end
      end

    end
  end
end

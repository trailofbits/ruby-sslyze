require 'sslyze/certificate/extensions/authority_information_access'
require 'sslyze/certificate/extensions/x509v3_crl_distribution_points'
require 'sslyze/certificate/extensions/x509v3_key_usage'
require 'sslyze/certificate/extensions/x509v3_extended_key_usage'
require 'sslyze/certificate/extensions/x509v3_basic_constraints'
require 'sslyze/certificate/extensions/x509v3_certificate_policies'

module SSLyze
  class Certificate
    class Extensions

      def initialize(node)
        @node = node
      end

      def x509v3_subject_key_identifier
        @x509v3_subject_key_identifier ||= @node.at('X509v3SubjectKeyIdentifier').inner_text
      end

      def authority_information_access
        @authority_information_access ||= AuthorityInformationAccess.new(@node.at('AuthorityInformationAccess'))
      end

      def x509v3_crl_distribution_points
        @x509v3_crl_distribution_points ||= X509v3CRLDistributionPoints.new(@node.at('X509v3CRLDistributionPoints'))
      end

      def x509v3_basic_constraints
        @x509v3_basic_constraints ||= if (constraints = @node.at('X509v3BasicConstraints'))
                                        X509v3BasicConstraints.new(constraints)
                                      end
      end

      def x509v3_key_usage
        @x509v3_key_usage ||= X509v3KeyUsage.new(@node.at('X509v3KeyUsage'))
      end

      def x509v3_extended_key_usage
        @x509v3_extended_key_usage ||= X509v3ExtendedKeyUsage.new(@node.at('X509v3ExtendedKeyUsage'))
      end

      def x509v3_subject_alternative_name(type = "DNS")
        @x509v3_subject_alternative_name ||= {}
        @x509v3_subject_alternative_name[type] ||= @node.search("X509v3SubjectAlternativeName/#{type}/listEntry").map do |dns|
          dns.inner_text
        end
      end

      def x509v3_authority_key_identifier
        @x509v3_authority_key_identifier ||= @node.at('X509v3AuthorityKeyIdentifier').inner_text
      end

      def x509v3_certificate_policies
        @x509v3_certificate_policies ||= X509v3CertificatePolicies.new(@node.at('X509v3CertificatePolicies'))
      end

    end
  end
end

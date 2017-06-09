require 'spec_helper'
require 'sslyze/x509/extension_set'

describe SSLyze::X509::ExtensionSet do
  let(:authority_key_identifier) do
    OpenSSL::X509::Extension.new("authorityKeyIdentifier", "keyid:3D:D3:50:A5:D6:A0:AD:EE:F3:4A:60:0A:65:D3:21:D4:F8:F8:D6:0F\n")
  end
  let(:subject_key_identifier) do
    OpenSSL::X509::Extension.new("subjectKeyIdentifier", "9F:62:7B:B2:88:0E:EE:1B:79:E0:69:24:E5:BA:3F:47:A6:0B:02:F0")
  end
  let(:subject_alt_name) do
    OpenSSL::X509::Extension.new("subjectAltName", "DNS:twitter.com, DNS:www.twitter.com")
  end
  let(:key_usage) do
    OpenSSL::X509::Extension.new("keyUsage", "Digital Signature, Key Encipherment", true)
  end
  let(:extended_key_usage) do
    OpenSSL::X509::Extension.new("extendedKeyUsage", "TLS Web Server Authentication, TLS Web Client Authentication")
  end
  let(:crl_distribution_points) do
    OpenSSL::X509::Extension.new("crlDistributionPoints", "\nFull Name:\n  URI:http://crl3.digicert.com/sha2-ev-server-g1.crl\n\nFull Name:\n  URI:http://crl4.digicert.com/sha2-ev-server-g1.crl\n")
  end
  let(:certificate_policies) do
    OpenSSL::X509::Extension.new("certificatePolicies", "Policy: 2.16.840.1.114412.2.1\n  CPS: https://www.digicert.com/CPS\nPolicy: 2.23.140.1.1\n")
  end
  let(:authority_info_access) do
    OpenSSL::X509::Extension.new("authorityInfoAccess", "OCSP - URI:http://ocsp.digicert.com\nCA Issuers - URI:http://cacerts.digicert.com/DigiCertSHA2ExtendedValidationServerCA.crt\n")
  end
  let(:basic_constraints) do
    OpenSSL::X509::Extension.new("basicConstraints", "CA:FALSE", true)
  end

  let(:openssl_x509_extensions) do
    [
      authority_key_identifier,
      subject_key_identifier,
      subject_alt_name,
      key_usage,
      extended_key_usage,
      crl_distribution_points,
      certificate_policies,
      authority_info_access,
      basic_constraints
    ]
  end

  subject { described_class.new(openssl_x509_extensions) }

  describe "#each" do
    context "when given a block" do
      it "must iterate over each wrapped Extension" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(*openssl_x509_extensions)
      end
    end

    context "when no block is given" do
      it "should return an Enumerator object" do
        expect(subject.each).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#has?" do
    context "when the given key matches an extension's OID" do
      let(:key) { 'subjectAltName' }

      it { expect(subject.has?(key)).to be true }
    end

    context "when the given key matches no extension's OID" do
      it { expect(subject.has?("foo")).to be false }
    end
  end

  describe "#[]" do
    context "when the given key matches an extension's OID" do
      let(:key) { 'subjectAltName' }

      it "must return that extension" do
        expect(subject[key].oid).to be == key
      end
    end

    context "when the given key matches no extension's OID" do
      it "must return nil" do
        expect(subject["foo"]).to be nil
      end
    end
  end

  describe "#to_a" do
    it "should return the Array of extensions" do
      expect(subject.to_a).to be == openssl_x509_extensions
    end
  end

  describe "#basic_constraints" do
    context "when there is a 'basiConstraints' extension" do
      it do
        expect(subject.basic_constraints).to be_kind_of(SSLyze::X509::Extensions::BasicConstraints)
      end

      it "should find the extensions with the 'basicConstraints' OID" do
        expect(subject.basic_constraints.oid).to be == 'basicConstraints'
      end
    end

    context "when there is no 'basicConstraints' extension" do
      let(:openssl_x509_extensions) { super() - [basic_constraints] }

      it { expect(subject.basic_constraints).to be nil }
    end
  end

  describe "#certificate_policies" do
    context "when there is a 'certificatePolicies' extension" do
      it do
        expect(subject.certificate_policies).to be_kind_of(SSLyze::X509::Extensions::CertificatePolicies)
      end

      it "should find the extensions with the 'certificatePolicies' OID" do
        expect(subject.certificate_policies.oid).to be == 'certificatePolicies'
      end
    end

    context "when there is no 'certificatePolicies' extension" do
      let(:openssl_x509_extensions) { super() - [certificate_policies] }

      it { expect(subject.certificate_policies).to be nil }
    end
  end

  describe "#crl_distribution_points" do
    context "when there is a 'crlDistributionPoints' extension" do
      it do
        expect(subject.crl_distribution_points).to be_kind_of(SSLyze::X509::Extensions::CRLDistributionPoints)
      end

      it "should find the extensions with the 'crlDistributionPoints' OID" do
        expect(subject.crl_distribution_points.oid).to be == 'crlDistributionPoints'
      end
    end

    context "when there is no 'crlDistributionPoints' extension" do
      let(:openssl_x509_extensions) { super() - [crl_distribution_points] }

      it { expect(subject.crl_distribution_points).to be nil }
    end
  end

  describe "#extended_key_usage" do
    context "when there is a 'extendedKeyUsage' extension" do
      it do
        expect(subject.extended_key_usage).to be_kind_of(SSLyze::X509::Extensions::ExtendedKeyUsage)
      end

      it "should find the extensions with the 'extendedKeyUsage' OID" do
        expect(subject.extended_key_usage.oid).to be == 'extendedKeyUsage'
      end
    end

    context "when there is no 'extendedKeyUsage' extension" do
      let(:openssl_x509_extensions) { super() - [extended_key_usage] }

      it { expect(subject.extended_key_usage).to be nil }
    end
  end

  describe "#key_usage" do
    context "when there is a 'keyUsage' extension" do
      it do
        expect(subject.key_usage).to be_kind_of(SSLyze::X509::Extensions::KeyUsage)
      end

      it "should find the extensions with the 'keyUsage' OID" do
        expect(subject.key_usage.oid).to be == 'keyUsage'
      end
    end

    context "when there is no 'keyUsage' extension" do
      let(:openssl_x509_extensions) { super() - [key_usage] }

      it { expect(subject.key_usage).to be nil }
    end
  end

  describe "#subject_alt_name" do
    context "when there is a 'subjectAltName' extension" do
      it do
        expect(subject.subject_alt_name).to be_kind_of(SSLyze::X509::Extensions::SubjectAltName)
      end

      it "should find the extensions with the 'subjectAltName' OID" do
        expect(subject.subject_alt_name.oid).to be == 'subjectAltName'
      end
    end

    context "when there is no 'subjectAltName' extension" do
      let(:openssl_x509_extensions) { super() - [subject_alt_name] }

      it { expect(subject.subject_alt_name).to be nil }
    end
  end
end

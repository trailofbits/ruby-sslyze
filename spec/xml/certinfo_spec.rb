require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo'

describe SSLyze::XML::Certinfo do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#received_certificate_chain" do
    it "should return a ReceivedCertificateChain object" do
      expect(subject.received_certificate_chain).to be_a(described_class::ReceivedCertificateChain)
    end
  end

  describe "#certificate_validation" do
    subject do
      described_class.new(xml.at("#{xpath}[receivedCertificateChain]"))
    end

    it "should return a CertificateValidation element" do
      expect(subject.certificate_validation).to be_kind_of(described_class::CertificateValidation)
    end
  end

  describe "#verified_certificate_chain" do
    it "should return the #verified_certificate_chain from within one of the #certificate_validation.path_validations" do
      expect(subject.verified_certificate_chain).to be_kind_of(described_class::CertificateValidation::VerifiedCertificateChain)
    end
  end

  describe "#ocsp_stapling" do
    subject do
      described_class.new(xml.at("#{xpath}[ocspStapling]"))
    end

    it "should return a OCSPStapling object" do
      expect(subject.ocsp_stapling).to be_kind_of(described_class::OCSPStapling)
    end
  end
end

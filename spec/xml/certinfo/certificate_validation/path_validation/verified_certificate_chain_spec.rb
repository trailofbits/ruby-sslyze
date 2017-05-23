require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

describe SSLyze::XML::Certinfo::CertificateValidation::PathValidation::VerifiedCertificateChain do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation/verifiedCertificateChain'))
  end

  describe "#has_sha1_signed_certificate?" do
    it "should return a Boolean value" do
      expect(subject.has_sha1_signed_certificate?).to be(true).or(be(false))
    end
  end

  describe "#each_certificate" do
    it "should yield successive Certificate objects" do
      expect { |b|
        subject.each_certificate(&b)
      }.to yield_successive_args(
        SSLyze::XML::Certinfo::Certificate,
        SSLyze::XML::Certinfo::Certificate
      )
    end
  end

  describe "#certificates" do
    subject { super().certificates }

    it do
      expect(subject).to_not be_empty
      expect(subject).to all(be_kind_of(SSLyze::XML::Certinfo::Certificate))
    end
  end
end

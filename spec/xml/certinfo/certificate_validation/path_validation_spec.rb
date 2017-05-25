require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

describe SSLyze::XML::Certinfo::CertificateValidation::PathValidation do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation'))
  end

  describe "#verified_certificate_chain" do
    context "when 'verifiedCertificateChain' XML children are present" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation[verifiedCertificateChain]'))
      end

      it do
        expect(subject.verified_certificate_chain).to be_kind_of(described_class::VerifiedCertificateChain)
      end
    end

    context "when there are no 'verifiedCertificateChain' XML children" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation[not(verifiedCertificateChain)]'))
      end

      it { expect(subject.verified_certificate_chain).to be nil }
    end
  end

  describe "#is_extended_validation_certificate?" do
    context "when the 'isExtendedValidationCertificate' XML attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation[@isExtendedValidationCertificate]'))
      end

      it "should return a Boolean type" do
        expect(subject.is_extended_validation_certificate?).to be(false).or(be(true))
      end
    end

    context "when the 'isExtendedValidationCertificate' XML attribute is omitted" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/pathValidation[not(@isExtendedValidationCertificate)]'))
      end

      it { expect(subject.is_extended_validation_certificate?).to be nil }
    end
  end
end

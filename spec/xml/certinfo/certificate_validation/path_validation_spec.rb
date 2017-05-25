require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

describe SSLyze::XML::Certinfo::CertificateValidation::PathValidation do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/certificateValidation/pathValidation' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#verified_certificate_chain" do
    context "when 'verifiedCertificateChain' XML children are present" do
      subject do
        described_class.new(xml.at("#{xpath}[verifiedCertificateChain]"))
      end

      it do
        expect(subject.verified_certificate_chain).to be_kind_of(described_class::VerifiedCertificateChain)
      end
    end

    context "when there are no 'verifiedCertificateChain' XML children" do
      subject do
        described_class.new(xml.at("#{xpath}[not(verifiedCertificateChain)]"))
      end

      it { expect(subject.verified_certificate_chain).to be nil }
    end
  end

  describe "#is_extended_validation_certificate?" do
    context "when the 'isExtendedValidationCertificate' XML attribute is present" do
      subject do
        described_class.new(xml.at("#{xpath}[@isExtendedValidationCertificate]"))
      end

      it "should return a Boolean type" do
        expect(subject.is_extended_validation_certificate?).to be(false).or(be(true))
      end
    end

    context "when the 'isExtendedValidationCertificate' XML attribute is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@isExtendedValidationCertificate)]"))
      end

      it { expect(subject.is_extended_validation_certificate?).to be nil }
    end
  end

  describe "#trust_store_version" do
    it "must return the 'trustStoreVersion' XML attribute" do
      expect(subject.trust_store_version).to be == '7.0.0 r1'
    end
  end

  describe "#using_trust_store" do
    it "must return the 'usingTrustStore' XML attribute" do
      expect(subject.using_trust_store).to be == 'AOSP'
    end
  end

  describe "#validation_result" do
    context "when the 'validationResult' attribute is set" do
      subject do
        described_class.new(xml.at("#{xpath}[@validationResult]"))
      end

      it "must return the 'validationResult' XML element" do
        expect(subject.validation_result).to be == :ok
      end
    end

    context "when the 'validationResult' attribute is not set" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@validationResult)]"))
      end

      it "must return the 'validationResult' XML element" do
        pending "need an example without the 'validationResult' XML attribute"

        expect(subject.validation_result).to be nil
      end
    end
  end

  describe "#ok?" do
    context "when the 'validationResult' attribute is set" do
      context "and is 'ok'" do
        subject do
          described_class.new(xml.at("#{xpath}[@validationResult=\"ok\"]"))
        end

        it { expect(subject.ok?).to be true }
      end

      context "but is not 'ok'" do
        subject do
          described_class.new(xml.at("#{xpath}[not(@validationResult=\"ok\")]"))
        end

        it do
          pending "need an example where the 'validationResult' isn't 'ok'"

          expect(subject.ok?).to be false
        end
      end
    end

    context "when the 'validationResult' attribute is not set" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@validationResult)]"))
      end

      it "must return the 'validationResult' XML element" do
        pending "need an example without the 'validationResult' XML attribute"

        expect(subject.ok?).to be nil
      end
    end
  end
end

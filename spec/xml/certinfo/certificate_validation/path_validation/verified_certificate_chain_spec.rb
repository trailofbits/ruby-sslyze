require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation/path_validation'

describe SSLyze::XML::Certinfo::CertificateValidation::PathValidation::VerifiedCertificateChain do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/certificateValidation/pathValidation/verifiedCertificateChain' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#has_sha1_signed_certificate?" do
    it "should return a Boolean value" do
      expect(subject.has_sha1_signed_certificate?).to be(true).or(be(false))
    end
  end

  describe "#each_certificate" do
    context "when at least one 'certificate' XML child exists" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it "should yield successive Certificate objects" do
        expect { |b|
          subject.each_certificate(&b)
        }.to yield_successive_args(
          SSLyze::XML::Certinfo::Certificate,
          SSLyze::XML::Certinfo::Certificate
        )
      end
    end

    context "when no 'certificate' XML children exist" do
      subject { described_class.new(xml.at("#{xpath}[not(./certificate)]")) }

      it "should not yield control" do
        pending "need an example with no 'certificate' XML children"

        expect { |b|
          subject.each_certificate(&b)
        }.to_not yield_control
      end
    end
  end

  describe "#certificates" do
    context "when at least one 'certificate' XML child exists" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it do
        expect(subject.certificates).to be_a(Array).and(
          all(be_kind_of(SSLyze::XML::Certinfo::Certificate))
        )
      end
    end

    context "when no 'certificate' XML children exist" do
      subject { described_class.new(xml.at("#{xpath}[not(./certificate)]")) }

      it do
        pending "need an example with no 'certificate' XML children"

        expect(subject.certificates).to be_empty
      end
    end
  end

  describe "#leaf" do
    context "when at least one 'certificate' XML child exists" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it do
        expect(subject.leaf).to be_a(SSLyze::XML::Certinfo::Certificate)
      end

      it "should select the first 'certificate' XML child" do
        expect(subject.leaf).to be == \
          SSLyze::XML::Certinfo::Certificate.new(xml.at("#{xpath}/certificate[1]"))
      end
    end

    context "when no 'certificate' XML children exist" do
      subject { described_class.new(xml.at("#{xpath}[not(./certificate)]")) }

      it do
        pending "need an example with no 'certificate' XML children"

        expect(subject.leaf).to be nil
      end
    end
  end

  describe "#root" do
    context "when at least one 'certificate' XML child exists" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it do
        expect(subject.root).to be_a(SSLyze::XML::Certinfo::Certificate)
      end

      it "should select the last 'certificate' XML child" do
        expect(subject.root).to be == \
          SSLyze::XML::Certinfo::Certificate.new(xml.at("#{xpath}/certificate[last()]"))
      end
    end

    context "when no 'certificate' XML children exist" do
      subject { described_class.new(xml.at("#{xpath}[not(./certificate)]")) }

      it do
        pending "need an example with no 'certificate' XML children"

        expect(subject.root).to be nil
      end
    end
  end
end

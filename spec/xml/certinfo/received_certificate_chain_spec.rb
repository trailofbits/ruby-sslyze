require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/received_certificate_chain'

describe SSLyze::XML::Certinfo::ReceivedCertificateChain do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/receivedCertificateChain' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#each_certificate" do
    context "when 'certificate' XML children are present" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it "should yield successive Certificate objects" do
        pending "need an example with 'certificate' child elements"

        expect { |b|
          subject.each_certificate(&b)
        }.to yield_successive_args(
          SSLyze::XML::Certinfo::Certificate,
          SSLyze::XML::Certinfo::Certificate
        )
      end
    end
  end

  describe "#certificates" do
    context "when 'certificate' XML children are present" do
      subject { described_class.new(xml.at("#{xpath}[certificate]")) }

      it do
        pending "need an example with 'certificate' child elements"

        expect(subject.certificates).to be_a(Array).and(
          all(be_kind_of(SSLyze::XML::Certinfo::Certificate))
        )
      end
    end
  end

  describe "#is_chain_order_valid?" do
    it "should return a Boolean value" do
      expect(subject.is_chain_order_valid?).to be(true).or(be(false))
    end
  end

  describe "#contains_anchor_certificate?" do
    context "when the 'containsAnchorCertificate' XML attribute is present" do
      subject do
        described_class.new(xml.at("#{xpath}[@containsAnchorCertificate]"))
      end

      it "should return a Boolean value" do
        expect(subject.contains_anchor_certificate?).to be(true).or(be(false))
      end
    end

    context "when the 'containsAnchorCertificate' XML attribute is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@containsAnchorCertificate)]"))
      end

      it do
        pending "need an example where 'containsAnchorCertificate' is missing"

        expect(subject.contains_anchor_certificate?).to be nil
      end
    end
  end
end

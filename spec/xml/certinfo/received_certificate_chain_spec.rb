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
      let(:xpath) { "#{super()}[certificate]" }
      let(:count) { node.xpath('./certificate').count    }

      it "should yield successive Certificate objects" do
        expect { |b|
          subject.each_certificate(&b)
        }.to yield_successive_args(
          *[SSLyze::XML::Certinfo::Certificate] * count
        )
      end
    end
  end

  describe "#certificates" do
    context "when 'certificate' XML children are present" do
      let(:xpath) { "#{super()}[certificate]" }

      it do
        expect(subject.certificates).to be_a(Array).and(
          all(be_kind_of(SSLyze::XML::Certinfo::Certificate))
        )
      end
    end
  end

  describe "#leaf" do
    context "when at least one 'certificate' XML child exists" do
      let(:xpath) { "#{super()}[certificate]" }

      it do
        expect(subject.leaf).to be_a(SSLyze::XML::Certinfo::Certificate)
      end

      it "should select the first 'certificate' XML child" do
        expect(subject.leaf).to be == \
          SSLyze::XML::Certinfo::Certificate.new(xml.at("#{xpath}/certificate[1]"))
      end
    end

    context "when no 'certificate' XML children exist" do
      let(:xpath) { "#{super()}[not(./certificate)]" }

      it do
        pending "need an example with no 'certificate' XML children"

        expect(subject.leaf).to be nil
      end
    end
  end

  describe "#each_intermediate" do
    context "when there are more than two 'certificate' XML children" do
      let(:xpath) { "#{super()}[count(certificate) > 2]" }
      let(:xpath_count) { xml.at(xpath).xpath('certificate').count - 2 }

      it "should yield the intermediate certificates" do
        expect { |b|
          subject.each_intermediate(&b)
        }.to yield_successive_args(
          *Array.new(xpath_count,SSLyze::XML::Certinfo::Certificate)
        )
      end
    end

    context "when there are two or fewer 'certificate' XML children" do
      let(:xpath) { "#{super()}[count(certificate) <= 2]" }

      it "should not yield anything" do
        expect { |b|
          subject.each_intermediate(&b)
        }.to_not yield_control
      end
    end
  end

  describe "#intermediates" do
    context "when there are more than two 'certificate' XML children" do
      let(:xpath) { "#{super()}[count(certificate) > 2]" }
      let(:xpath_count) { xml.at(xpath).xpath('certificate').count - 2 }

      it "should yield the intermediate certificates" do
        expect(subject.intermediates).to be_a(Array).and(all(be_kind_of(SSLyze::XML::Certinfo::Certificate)))
      end
    end

    context "when there are two or fewer 'certificate' XML children" do
      let(:xpath) { "#{super()}[count(certificate) <= 2]" }

      it "should not yield anything" do
        expect(subject.intermediates).to be_empty
      end
    end
  end

  describe "#root" do
    context "when at least one 'certificate' XML child exists" do
      let(:xpath) { "#{super()}[certificate]" }

      it do
        expect(subject.root).to be_a(SSLyze::XML::Certinfo::Certificate)
      end

      it "should select the last 'certificate' XML child" do
        expect(subject.root).to be == \
          SSLyze::XML::Certinfo::Certificate.new(xml.at("#{xpath}/certificate[last()]"))
      end
    end

    context "when no 'certificate' XML children exist" do
      let(:xpath) { "#{super()}[not(./certificate)]" }

      it do
        pending "need an example with no 'certificate' XML children"

        expect(subject.root).to be nil
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
      let(:xpath) { "#{super()}[@containsAnchorCertificate]" }

      it "should return a Boolean value" do
        expect(subject.contains_anchor_certificate?).to be(true).or(be(false))
      end
    end

    context "when the 'containsAnchorCertificate' XML attribute is omitted" do
      let(:xpath) { "#{super()}[not(@containsAnchorCertificate)]" }

      it do
        pending "need an example where 'containsAnchorCertificate' is missing"

        expect(subject.contains_anchor_certificate?).to be nil
      end
    end
  end
end

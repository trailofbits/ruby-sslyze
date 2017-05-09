require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certificate_chain'

describe SSLyze::XML::CertificateChain do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain')) }

  describe "#each" do
    context "when given a block" do
      it "should yield Certificate objects" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(XML::Certificate, XML::Certificate)
      end
    end

    context "when not given a block" do
      it "should return an Enumerator" do
        expect(subject.each).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#leaf" do
    it "should return a Certificate with position leaf" do
      expect(subject.leaf).to be_a(XML::Certificate)
      expect(subject.leaf.position).to be :leaf
    end
  end

  describe "#each_intermediate" do
    context "when given a block" do
      it "should return Certificates with position intermediate" do
        expect { |b|
          subject.each_intermediate(&b)
        }.to yield_successive_args(XML::Certificate)
      end
    end

    context "when not given a block" do
      it "should return an Enumerator" do
        expect(subject.each_intermediate).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#intermediate" do
    it "should return all intermediate certificates" do
      expect(subject.intermediate).to all(be_kind_of(XML::Certificate))
    end
  end

  describe "#root" do
    it "should find the last intermediate certificate" do
      expect(subject.root.sha1_fingerprint).to be == subject.intermediate.to_a.last.sha1_fingerprint
    end
  end

end

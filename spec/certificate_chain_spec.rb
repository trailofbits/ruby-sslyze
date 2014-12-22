require 'spec_helper'
require 'xml_examples'
require 'sslyze/certificate_chain'

describe SSLyze::CertificateChain do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain')) }

  describe "#each" do
    context "when given a block" do
      it "should yield Certificate objects" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(Certificate, Certificate)
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
      expect(subject.leaf).to be_a(Certificate)
      expect(subject.leaf.position).to be :leaf
    end
  end

  describe "#intermediate" do
    context "when given a block" do
      it "should return Certificates with position intermediate" do
        expect { |b|
          subject.intermediate(&b)
        }.to yield_successive_args(Certificate)
      end
    end

    context "when not given a block" do
      it "should return an Enumerator" do
        expect(subject.intermediate).to be_kind_of(Enumerator)
      end
    end
  end

end
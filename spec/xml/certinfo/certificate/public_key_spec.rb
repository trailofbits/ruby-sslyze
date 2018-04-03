require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate/public_key'

describe SSLyze::XML::Certinfo::Certificate::PublicKey do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/receivedCertificateChain/certificate/publicKey' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#algorithm" do
    context "when the algorithm attribute is RSA" do
      let(:xpath) { "#{super()}[@algorithm='RSA']" }

      it { expect(subject.algorithm).to be :RSA }
    end

    context "when the algorithm attribute is DSA" do
      let(:xpath) { "#{super()}[@algorithm='DSA']" }

      pending "need to find a target with a DSA public key" do
        expect(subject.algorithm).to be :DSA
      end
    end

    context "when the algorithm attribute is EllipticCurve" do
      let(:xpath) { "#{super()}[@algorithm='EllipticCurve']" }

      it { expect(subject.algorithm).to be :EC }
    end
  end

  describe "#size" do
    let(:expected_size) { 2048 }
    let(:xpath) { "#{super()}[@size=#{expected_size}]" }

    it "should parse the size attribute" do
      expect(subject.size).to be expected_size
    end
  end

  describe "#curve" do
    context "when the curve attribute is present" do
      let(:expected_curve) { :secp256r1 }
      let(:xpath) { "#{super()}[@curve='#{expected_curve}']" }

      it { expect(subject.curve).to be(expected_curve) }
    end

    context "when the curve attribute is missing" do
      let(:xpath) { "#{super()}[not(@curve)]" }

      it { expect(subject.curve).to be nil }
    end
  end

  describe "#exponent" do
    context "when the exponent attribute is present" do
      let(:xpath) { "#{super()}[@exponent]" }

      it { expect(subject.exponent).to be 65537 }
    end

    context "when the exponent attribute is missing" do
      let(:xpath) { "#{super()}[not(@exponent)]" }

      it { expect(subject.exponent).to be nil }
    end
  end
end

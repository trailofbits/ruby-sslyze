require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/key_exchange'

describe SSLyze::XML::KeyExchange do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite/keyExchange')) }

  describe "#a" do
    it "should parse the A attribute" do
      expect(subject.a).to be == '0x00ffffffff00000001000000000000000000000000fffffffffffffffffffffffc'
    end
  end

  describe "#b" do
    it "should parse the B attribute" do
      expect(subject.b).to be == '0x5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b'
    end
  end

  describe "#cofactor" do
    it "should parse the Cofactor attribute" do
      expect(subject.cofactor).to be == 1
    end
  end

  describe "#field_type" do
    it "should parse the Field_Type attribute" do
      expect(subject.field_type).to be == 'prime-field'
    end
  end

  describe "#generator" do
    it "should parse the Generator attribute" do
      expect(subject.generator).to be == '0x046b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c2964fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5'
    end
  end

  describe "#generator_type" do
    it "should parse the GeneratorType attribute" do
      expect(subject.generator_type).to be == :uncompressed
    end
  end

  describe "#group_size" do
    it "should parse the GroupSize attribute" do
      expect(subject.group_size).to be == 256
    end
  end

  describe "#prime" do
    it "should parse the Prime attribute" do
      expect(subject.prime).to be == '0x00ffffffff00000001000000000000000000000000ffffffffffffffffffffffff'
    end
  end

  describe "#seed" do
    it "should parse the Seed attribute" do
      expect(subject.seed).to be == '0xc49d360886e704936a6678e1139d26b7819f7e90'
    end
  end

  describe "#type" do
    it "should parse the Type attribute" do
      expect(subject.type).to be == :ECDH
    end
  end

  describe "#dh?" do
    context "when #type is :DH" do
      before { expect(subject).to receive(:type).and_return(:DH) }

      it { expect(subject.dh?).to be(true) }
    end

    context "when #type is :ECDHE " do
      before { expect(subject).to receive(:type).and_return(:ECDHE) }

      it { expect(subject.dh?).to be(false) }
    end
  end

  describe "#ecdhe?" do
    context "when #type is :DH" do
      before { expect(subject).to receive(:type).and_return(:DH) }

      it { expect(subject.ecdhe?).to be(false) }
    end

    context "when #type is :ECDHE " do
      before { expect(subject).to receive(:type).and_return(:ECDHE) }

      it { expect(subject.ecdhe?).to be(true) }
    end
  end
end

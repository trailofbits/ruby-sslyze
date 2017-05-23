require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/protocol'

describe SSLyze::XML::Protocol do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/tlsv1_2' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#name" do
    it "should return the protocol name" do
      expect(subject.name).to be == :tlsv1_2
    end
  end

  describe "#title" do
    it "must parse the title attribute" do
      expect(subject.title).to be == 'TLSV1_2 Cipher Suites'
    end
  end

  describe "#preferred_cipher_suite" do
    context "when the 'preferredCipherSuite' XML element has children" do
      let(:xpath) do
        '/document/results/target/*[preferredCipherSuite/cipherSuite]'
      end

      it do
        expect(subject.preferred_cipher_suite).to be_kind_of(described_class::CipherSuite)
      end
    end

    context "when the preferredCipherSuite' XML element has no children" do
      let(:xpath) do
        '/document/results/target/*[preferredCipherSuite][not(preferredCipherSuite/cipherSuite)]'
      end

      it do
        expect(subject.preferred_cipher_suite).to be nil
      end
    end
  end

  describe "#each_accepted_cipher_suite" do
    it "should yield CipherSuite objects" do
      expect { |b|
        subject.each_accepted_cipher_suite(&b)
      }
    end

    context "when given no block" do
      it { expect(subject.each_accepted_cipher_suite).to be_an(Enumerator) }
    end
  end

  describe "#accepted_cipher_suites" do
    it "should return an Array of CipherSuites" do
      expect(subject.accepted_cipher_suites).to be_an(Array).and(
        all(be_a(described_class::CipherSuite))
      )
    end
  end

  describe "#each_rejected_cipher_suite" do
    it "should yield CipherSuite objects" do
      expect { |b|
        subject.each_rejected_cipher_suite(&b)
      }
    end

    context "when given no block" do
      it { expect(subject.each_rejected_cipher_suite).to be_an(Enumerator) }
    end
  end

  describe "#rejected_cipher_suites" do
    it "should return an Array of CipherSuites" do
      expect(subject.rejected_cipher_suites).to be_an(Array).and(
        all(be_a(described_class::CipherSuite))
      )
    end
  end

  describe "#supported?" do
    context "when there are preferred cipher suites" do
      it "should return true" do
        expect(subject.supported?).to be(true)
      end
    end
  end

  describe "#each_error" do
    it "should yield CipherSuite objects" do
      pending "need a target with non-empty '<errors/>'"

      expect { |b|
        subject.each_error(&b)
      }.to yield_successive_args(described_class::CipherSuite)
    end

    context "when given no block" do
      it { expect(subject.each_error).to be_an(Enumerator) }
    end
  end

  describe "#errors" do
    it "should return an Array of CipherSuites" do
      expect(subject.errors).to be_an(Array).and(
        all(be_a(described_class::CipherSuite))
      )
    end
  end
end

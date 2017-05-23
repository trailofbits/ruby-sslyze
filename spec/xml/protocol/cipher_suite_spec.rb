require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/protocol/cipher_suite'

describe SSLyze::XML::Protocol::CipherSuite do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/tlsv1_2/preferredCipherSuite/cipherSuite')) }

  describe "#name" do
    it "should parse the name attribute" do
      expect(subject.name).to be == 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
    end
  end

  describe "#rfc_name" do
    it "should return the RFC cipher suite name" do
      expect(subject.rfc_name).to be == 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
    end
  end

  describe "#openssl_name" do
    it "should map the RFC name back to the OpenSSL name" do
      expect(subject.openssl_name).to be == 'ECDHE-RSA-AES128-GCM-SHA256'
    end
  end

  describe "#connection_status" do
    it "should parse the connectionStatus attribute" do
      expect(subject.connection_status).to be == 'HTTP 200 OK'
    end
  end

  describe "#anonymous?" do
    it "should query the anonymous attribute" do
      expect(subject.anonymous?).to be false
    end
  end

  describe "#key_size" do
    it "should return the keySize attribute" do
      expect(subject.key_size).to be 128
    end
  end

  describe "#key_exchange" do
    context "when the keyExchange child is present" do
      subject do
        described_class.new(xml.at('/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite[keyExchange]'))
      end

      it do
        expect(subject.key_exchange).to be_kind_of(described_class::KeyExchange)
      end
    end

    context "when the keyExchange object is missing" do
      subject do
        described_class.new(xml.at('/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite[not(./keyExchange)]'))
      end

      it { expect(subject.key_exchange).to be nil }
    end
  end

end

require 'spec_helper'
require 'xml_examples'
require 'sslyze/cipher_suite'

describe SSLyze::CipherSuite do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite')) }

  describe "#name" do
    it "should parse the name attribute" do
      expect(subject.name).to be == 'AES128-GCM-SHA256'
    end
  end

  describe "#rfc_name" do
    it "should map the openssl name back to the RFC name" do
      expect(subject.rfc_name).to be == 'TLS_RSA_WITH_AES_128_GCM_SHA256'
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

  describe "#key_exchange" do
    context "when the keyExchange child is present" do
      subject { described_class.new(xml.at('/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite[keyExchange]')) }

      it "should return a KeyExchange object" do
        expect(subject.key_exchange).to be_kind_of(KeyExchange)
      end
    end

    context "when the keyExchange object is missing" do
      it "should return nil" do
        expect(subject.key_exchange).to be nil
      end
    end
  end

end

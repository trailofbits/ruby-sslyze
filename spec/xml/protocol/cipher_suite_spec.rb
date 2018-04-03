require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/protocol/cipher_suite'

describe SSLyze::XML::Protocol::CipherSuite do
  include_examples "XML specs"

  let(:expected_name) { 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256' }

  let(:xpath) { '/document/results/target/tlsv1_2/preferredCipherSuite/cipherSuite' }

  describe "#name" do
    let(:xpath) { "#{super()}[@name='#{expected_name}']"  }

    it "should parse the name attribute" do
      expect(subject.name).to be == expected_name
    end
  end

  describe "#rfc_name" do
    let(:xpath) { "#{super()}[@name='#{expected_name}']"  }

    it "should return the RFC cipher suite name" do
      expect(subject.rfc_name).to be == expected_name
    end
  end

  describe "#openssl_name" do
    let(:openssl_name) { 'ECDHE-RSA-AES128-GCM-SHA256' }
    let(:xpath) { "#{super()}[@name='#{expected_name}']"  }

    it "should map the RFC name back to the OpenSSL name" do
      expect(subject.openssl_name).to be == openssl_name
    end
  end

  describe "#connection_status" do
    it "should parse the connectionStatus attribute" do
      expect(subject.connection_status).to be == node['connectionStatus']
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
    let(:xpath) { '/document/results/target/tlsv1_2/acceptedCipherSuites/cipherSuite' }

    context "when the keyExchange child is present" do
      let(:xpath) { "#{super()}[keyExchange]" }

      it do
        expect(subject.key_exchange).to be_kind_of(described_class::KeyExchange)
      end
    end

    context "when the keyExchange object is missing" do
      let(:xpath) { "#{super()}[not(./keyExchange)]" }

      it { expect(subject.key_exchange).to be nil }
    end
  end

end

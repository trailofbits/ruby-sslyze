require 'spec_helper'
require 'sslyze/x509/extension_set'

describe SSLyze::X509::ExtensionSet do
  let(:openssl_x509_extensions) do
    [
      OpenSSL::X509::Extension.new("authorityKeyIdentifier", "keyid:3D:D3:50:A5:D6:A0:AD:EE:F3:4A:60:0A:65:D3:21:D4:F8:F8:D6:0F\n"),
      OpenSSL::X509::Extension.new("subjectKeyIdentifier", "9F:62:7B:B2:88:0E:EE:1B:79:E0:69:24:E5:BA:3F:47:A6:0B:02:F0"),
      OpenSSL::X509::Extension.new("subjectAltName", "DNS:twitter.com, DNS:www.twitter.com"),
      OpenSSL::X509::Extension.new("keyUsage", "Digital Signature, Key Encipherment", true)
    ]
  end

  subject { described_class.new(openssl_x509_extensions) }

  describe "#each" do
    context "when given a block" do
      it "must iterate over each OpenSSL::X509::Extension" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(*openssl_x509_extensions)
      end
    end

    context "when no block is given" do
      it "should return an Enumerator object" do
        expect(subject.each).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#has?" do
    context "when the given key matches an extension's OID" do
      let(:key) { 'subjectAltName' }

      it { expect(subject.has?(key)).to be true }
    end

    context "when the given key matches no extension's OID" do
      it { expect(subject.has?("foo")).to be false }
    end
  end

  describe "#[]" do
    context "when the given key matches an extension's OID" do
      let(:key) { 'subjectAltName' }

      it "must return that extension" do
        expect(subject[key].oid).to be == key
      end
    end

    context "when the given key matches no extension's OID" do
      it "must return nil" do
        expect(subject["foo"]).to be nil
      end
    end
  end

  describe "#to_a" do
    it "should return the Array of extensions" do
      expect(subject.to_a).to be == openssl_x509_extensions
    end
  end
end

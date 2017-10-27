require 'spec_helper'
require 'openssl'

require 'sslyze/x509/public_key'

describe SSLyze::X509::PublicKey do
  let(:key_size) { 1024 }

  let(:rsa_key) { OpenSSL::PKey::RSA.new(key_size) }
  let(:dsa_key) { OpenSSL::PKey::DSA.new(key_size) }
  let(:dh_key)  { OpenSSL::PKey::DH.new(key_size)  }
  let(:ec_key)  { OpenSSL::PKey::EC.new }

  describe "#algorithm" do
    context "when the pkey is an OpenSSL::PKey::RSA key" do
      let(:pkey) { rsa_key }

      subject { described_class.new(pkey) }

      it { expect(subject.algorithm).to be :rsa }
    end

    context "when the pkey is an OpenSSL::PKey::DSA key" do
      let(:pkey) { dsa_key }

      subject { described_class.new(pkey) }

      it { expect(subject.algorithm).to be :dsa }
    end

    context "when the pkey is an OpenSSL::PKey::DH key" do
      let(:pkey) { dh_key }

      subject { described_class.new(pkey) }

      it { expect(subject.algorithm).to be :dh }
    end

    context "when the pkey is an OpenSSL::PKey::EC key" do
      let(:pkey) { ec_key }

      subject { described_class.new(pkey) }

      it { expect(subject.algorithm).to be :ec }
    end
  end

  describe "#size" do
    context "when the pkey is an OpenSSL::PKey::RSA key" do
      let(:pkey) { rsa_key }

      subject { described_class.new(pkey) }

      it "to infer the key size from pkey.n.num_bits" do
        expect(subject.size).to (be == pkey.n.num_bits).and(be == key_size)
      end
    end

    context "when the pkey is an OpenSSL::PKey::DSA key" do
      let(:pkey) { dsa_key }

      subject { described_class.new(pkey) }

      it "to infer the key size from pkey.p.num_bits" do
        expect(subject.size).to (be == pkey.p.num_bits).and(be == key_size)
      end
    end

    context "when the pkey is an OpenSSL::PKey::DH key" do
      let(:pkey) { dh_key }

      subject { described_class.new(pkey) }

      it "to infer the key size from pkey.p.num_bits" do
        expect(subject.size).to (be == pkey.p.num_bits).and(be == key_size)
      end
    end

    context "when the pkey is an OpenSSL::PKey::EC key" do
      let(:pkey) { ec_key }

      subject { described_class.new(pkey) }

      it do
        expect { subject.size }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "#to_der" do
    let(:pkey) { rsa_key }

    subject { described_class.new(pkey) }

    it "should call the public key's #to_der method" do
      expect(pkey).to receive(:to_der)

      subject.to_der
    end
  end

  describe "#to_text" do
    let(:pkey) { rsa_key }

    subject { described_class.new(pkey) }

    it "should call the public key's #to_text method" do
      expect(pkey).to receive(:to_text)

      subject.to_text
    end
  end
end

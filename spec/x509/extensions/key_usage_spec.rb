require 'spec_helper'
require 'sslyze/x509/extensions/key_usage'

describe SSLyze::X509::Extensions::KeyUsage do
  let(:uses) do
    [
      'Key Encipherment',
      'Digital Signature',
      'CRL Sign',
      'Certificate Sign'
    ]
  end
  let(:value) { uses.join(', ') }

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('keyUsage', value)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#uses" do
    it "should parse the comma deliminated value" do
      expect(subject.uses).to be == uses
    end
  end

  describe "#each" do
    it "should yield each parsed use" do
      expect { |b|
        subject.each(&b)
      }.to yield_successive_args(*uses)
    end
  end

  describe "#key_encipherment?" do
    context "when 'Key Encipherment' is present" do
      it { expect(subject.key_encipherment?).to be true }
    end

    context "when 'Key Encipherment' is not present" do
      let(:uses) { super() - ['Key Encipherment'] }

      it { expect(subject.key_encipherment?).to be false }
    end
  end

  describe "#digital_signature?" do
    context "when 'Digital Signature' is present" do
      it { expect(subject.digital_signature?).to be true }
    end

    context "when 'Digital Signature' is not present" do
      let(:uses) { super() - ['Digital Signature'] }

      it { expect(subject.digital_signature?).to be false }
    end
  end

  describe "#crl_sign?" do
    context "when 'CRL Sign' is present" do
      it { expect(subject.crl_sign?).to be true }
    end

    context "when 'CRL Sign' is not present" do
      let(:uses) { super() - ['CRL Sign'] }

      it { expect(subject.crl_sign?).to be false }
    end
  end

  describe "#certificate_sign?" do
    context "when 'Certificate Sign' is present" do
      it { expect(subject.certificate_sign?).to be true }
    end

    context "when 'Certificate Sign' is not present" do
      let(:uses) { super() - ['Certificate Sign'] }

      it { expect(subject.certificate_sign?).to be false }
    end
  end
end

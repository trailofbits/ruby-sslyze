require 'spec_helper'
require 'sslyze/x509/extensions/extended_key_usage'

describe SSLyze::X509::Extensions::ExtendedKeyUsage do
  let(:uses) do
    [
      'TLS Web Server Authentication',
      'TLS Web Client Authentication'
    ]
  end
  let(:value) { uses.join(', ') }

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('extendedKeyUsage', value)
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

  describe "#tls_web_server_authentication?" do
    context "when 'TLS Web Server Authentication' is present" do
      it { expect(subject.tls_web_server_authentication?).to be true }
    end

    context "when 'TLS Web Server Authentication' is not present" do
      let(:uses) { super() - ['TLS Web Server Authentication'] }

      it { expect(subject.tls_web_server_authentication?).to be false }
    end
  end

  describe "#tls_web_client_authentication?" do
    context "when 'TLS Web Client Authentication' is present" do
      it { expect(subject.tls_web_client_authentication?).to be true }
    end

    context "when 'TLS Web Client Authentication' is not present" do
      let(:uses) { super() - ['TLS Web Client Authentication'] }

      it { expect(subject.tls_web_client_authentication?).to be false }
    end
  end
end

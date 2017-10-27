require 'spec_helper'
require 'openssl'

require 'sslyze/x509/extensions/crl_distribution_points'

describe SSLyze::X509::Extensions::CRLDistributionPoints do
  let(:uri1) { URI('http://crl3.digicert.com/sha2-ha-server-g5.crl') }
  let(:uri2) { URI('http://crl4.digicert.com/sha2-ha-server-g5.crl') }
  let(:value) do
    %{
Full Name:
  URI:#{uri1}

Full Name:
  URI:#{uri2}
}
  end

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('crlDistributionPoints',value)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#uris" do
    it "should parse each 'URI:' value" do
      expect(subject.uris).to be == [uri1, uri2]
    end
  end

  describe "#each" do
    it "should yield each parsed 'URI:' value" do
      expect { |b|
        subject.each(&b)
      }.to yield_successive_args(uri1, uri2)
    end
  end
end

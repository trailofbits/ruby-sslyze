require 'spec_helper'
require 'openssl'

require 'sslyze/x509/extensions/certificate_policies'

describe SSLyze::X509::Extensions::CertificatePolicies do
  let(:policy) { 'X509v3 Any Policy' }
  let(:cps)    { URI('https://www.digicert.com/CPS') }
  let(:value)  { "Policy: #{policy}\n  CPS: #{cps}\n" }

  let(:openssl_x509_extension) do
    OpenSSL::X509::Extension.new('certificatePolicies', value)
  end

  subject { described_class.new(openssl_x509_extension) }

  describe "#policies" do
    it "must yield #{described_class::Policy} objects" do
      expect(subject.policies).to all(be_kind_of(described_class::Policy))
    end

    it "should capture the text following 'Policy: '" do
      expect(subject.policies.first.policy).to be == policy
    end

    it "should capture the URI following '  CPS: '" do
      expect(subject.policies.first.cps).to be == cps
    end
  end

  describe "#each" do
    it "should yield #{described_class::Policy} objects" do
      expect { |b|
        subject.each(&b)
      }.to yield_successive_args(*Array.new(subject.length,described_class::Policy))
    end
  end
end

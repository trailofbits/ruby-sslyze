require 'spec_helper'
require 'xml_examples'
require 'sslyze/cert_info'

describe SSLyze::CertInfo do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo')) }

  describe "#chain" do
    it "should return a CertificateChain object" do
      expect(subject.chain).to be_a(CertificateChain)
    end
  end

  describe "#validation" do
    it "should return a CertificateValidation element" do
      expect(subject.validation).to be_kind_of(CertificateValidation)
    end
  end

  describe "#ocsp_response" do
    subject { described_class.new(xml.at('/document/results/target/certinfo[ocspStapling/ocspResponse]')) }

    it "should return a OCSPResponse object" do
      expect(subject.ocsp_response).to be_kind_of(OCSPResponse)
    end
  end
end

require 'spec_helper'
require 'xml_examples'
require 'sslyze/cert_info'

describe SSLyze::CertInfo do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo')) }

  describe "#chain" do
    it "should return Certificate objects" do
      expect(subject.chain).to all(be_a(Certificate))
    end
  end

  describe "#validation" do
    it "should return a CertificateValidation element" do
      expect(subject.validation).to be_kind_of(CertificateValidation)
    end
  end

  describe "#ocsp_stapling" do
    it "should parse the error attribute in ocspStapling" do
      expect(subject.ocsp_stapling).to be == 'Server did not send back an OCSP response'
    end
  end
end

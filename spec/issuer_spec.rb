require 'spec_helper'
require 'xml_examples'
require 'sslyze/certificate'

describe SSLyze::Certificate::Issuer do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain/certificate/issuer')) }

  describe "#country_name" do
    it "should parse the countryName" do
      expect(subject.country_name).to be == 'US'
    end
  end

  describe "#common_name" do
    it "should parse the commonName element" do
      expect(subject.common_name).to be == 'DigiCert SHA2 Extended Validation Server CA'
    end
  end

  describe "#organizational_unit_name" do
    it "should parse the organizationalUnitName element" do
      expect(subject.organizational_unit_name).to be == 'www.digicert.com'
    end
  end

  describe "#organization_name" do
    it "should parse the organizationName element" do
      expect(subject.organization_name).to be == 'DigiCert Inc'
    end
  end
end

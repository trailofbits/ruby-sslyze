require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certificate'

describe SSLyze::XML::Certificate::Subject do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain/certificate/subject')) }

  describe "#organizational_unit_name" do
    it "should parse the organizationUnitName element" do
      expect(subject.organizational_unit_name).to be == 'Information Security'
    end
  end

  describe "#organization_name" do
    it "should parse the organizationName element" do
      expect(subject.organization_name).to be == 'GitHub, Inc.'
    end
  end

  describe "#business_category" do
    it "should parse the businessCategory element" do
      expect(subject.business_category).to be == 'Private Organization'
    end
  end

  describe "#serial_number" do
    it "should parse the serialNumber element" do
      expect(subject.serial_number).to be == 5157550
    end
  end

  describe "#common_name" do
    it "should parse the commonName element" do
      expect(subject.common_name.name).to be == 'github.com'
    end
  end

  describe "#state_or_province_name" do
    it "should parse the stateOrProvinceName element" do
      expect(subject.state_or_province_name).to be == 'California'
    end
  end

  describe "#country_name" do
    it "should parse the countryName element" do
      expect(subject.country_name).to be == 'US'
    end
  end

  describe "#street_address" do
    it "should parse the streetAddress element" do
      expect(subject.street_address).to be == '548 4th Street'
    end
  end

  describe "#locality_name" do
    it "should parse the localityName element" do
      expect(subject.locality_name).to be == 'San Francisco'
    end
  end

  describe "#postal_code" do
    it "should parse the postalCode element" do
      expect(subject.postal_code).to be == '94107'
    end
  end
end

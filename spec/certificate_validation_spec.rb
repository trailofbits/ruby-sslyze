require 'spec_helper'
require 'xml_examples'
require 'sslyze/certificate_validation'

describe SSLyze::CertificateValidation do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateValidation')) }

  describe "#hostname?" do
    it "should query hostnameValidation/@certificateMatchesServerHostname" do
      expect(subject.hostname?).to be true
    end
  end

  describe "#path" do
    it "should parse the pathValidation elements into a Hash" do
      expect(subject.path).to be == {
        'Mozilla NSS - 08/2014' => true,
        'Microsoft - 08/2014' => true,
        'Apple - OS X 10.9.4' => true,
        'Java 6 - Update 65' => true
      }
    end
  end
end

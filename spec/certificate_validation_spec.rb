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

  describe "#results" do
    it "should parse the pathValidation elements into a Hash" do
      expect(subject.results).to be == {
        'Mozilla NSS' => 'ok',
        'Microsoft' => 'ok',
        'Apple' => 'ok',
        'Java 6' => 'ok',
        'Google' => 'ok' 
      }
    end
  end

  describe "#path" do
    it "should check if each pathValidation/@validationResult is 'ok'" do
      expect(subject.path).to be == {
        'Mozilla NSS' => true,
        'Microsoft' => true,
        'Apple' => true,
        'Java 6' => true,
        'Google' => true
      }
    end
  end
end

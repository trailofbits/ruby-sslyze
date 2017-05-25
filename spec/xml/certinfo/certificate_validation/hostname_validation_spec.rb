require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation/hostname_validation'

describe SSLyze::XML::Certinfo::CertificateValidation::HostnameValidation do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/certinfo/certificateValidation/hostnameValidation'))
  end

  describe "#certificate_matches_server_hostname?" do
    it "should return a Boolean value" do
      expect(subject.certificate_matches_server_hostname?).to be true
    end
  end

  describe "#server_hostname" do
    it "should return the serverHostname attribute" do
      expect(subject.server_hostname).to be == 'twitter.com'
    end
  end
end

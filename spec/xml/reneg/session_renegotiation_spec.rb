require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/reneg/session_renegotiation'

describe SSLyze::XML::Reneg::SessionRenegotiation do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/reneg/sessionRenegotiation'))
  end

  describe "#can_be_client_initiated?" do
    it "should return the 'canBeClientInitiated' attribute" do
      expect(subject.can_be_client_initiated?).to be(true).or(be(false))
    end
  end

  describe "#is_secure?" do
    it "should return the 'isSecure' attribute" do
      expect(subject.is_secure?).to be(true).or(be(false))
    end
  end
end

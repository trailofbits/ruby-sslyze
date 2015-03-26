require 'spec_helper'
require 'xml_examples'
require 'sslyze/ocsp_response'

describe SSLyze::OCSPResponse do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/ocspResponse')) }

  describe "#trusted?" do
    it "should query ocspResponse/@isTrustedByMozillaCAStore" do
      expect(subject.trusted?).to be true
    end
  end
end

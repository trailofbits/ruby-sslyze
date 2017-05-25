require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo'

describe SSLyze::XML::Certinfo::OCSPStapling do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/certinfo/ocspStapling'))
  end

  describe "#ocsp_response" do
    context "when the 'ocspResponse' element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/ocspStapling[ocspResponse]'))
      end

      it do
        expect(subject.ocsp_response).to be_kind_of(described_class::OCSPResponse)
      end
    end

    context "when the 'ocspResponse' element is missing" do
      subject do
        described_class.new(xml.at('/document/results/target/certinfo/ocspStapling[not(ocspResponse)]'))
      end

      it { expect(subject.ocsp_response).to be nil }
    end
  end
end

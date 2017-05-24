require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/ocsp_stapling/ocsp_response'

describe SSLyze::XML::Certinfo::OCSPStapling::OCSPResponse do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/ocspStapling/ocspResponse' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#is_trusted_by_mozilla_ca_store?" do
    it "should query @isTrustedByMozillaCAStore" do
      expect(subject.is_trusted_by_mozilla_ca_store?).to be true
    end
  end

  describe "#responder_id" do
    it "should parse the 'responderID' XML element" do
      expect(subject.responder_id).to be == '5168FF90AF0207753CCCD9656462A212B859723B'
    end
  end

  describe "#response_status" do
    it "should query responseStatus" do
      expect(subject.response_status).to be == :successful
    end
  end

  describe "#successful?" do
    context "when responseStatus is 'successful'" do
      subject do
        described_class.new(xml.at("#{xpath}[responseStatus/text()=\"successful\"]"))
      end

      specify { expect(subject.successful?).to be true }
    end

    context "when status is not :successful" do
      before do
        expect(subject).to receive(:response_status).and_return(:failed)
      end

      specify { expect(subject.successful?).to be false }
    end
  end

  describe "#produced_at" do
    it "should query producedAt and return a Time object" do
      expect(subject.produced_at).to be == Time.parse('May 24 11:10:00 2017 GMT')
    end
  end
end

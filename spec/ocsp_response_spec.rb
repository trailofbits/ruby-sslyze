require 'spec_helper'
require 'xml_examples'
require 'sslyze/ocsp_response'

describe SSLyze::OCSPResponse do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/ocspStapling/ocspResponse')) }

  describe "#trusted?" do
    it "should query @isTrustedByMozillaCAStore" do
      expect(subject.trusted?).to be true
    end
  end

  describe "#type" do
    it "should query responseType" do
      expect(subject.type).to be == 'Basic OCSP Response'
    end
  end

  describe "#responder_id" do
    it "should query responderID" do
      expect(subject.responder_id).to be == '0E7DB19F96176475CE3E5D98725AF4ACADA03FAF'
    end
  end

  describe "#version" do
    it "should query version" do
      expect(subject.version).to be 1
    end
  end

  describe "#status" do
    it "should query responseStatus" do
      expect(subject.status).to be == :successful
    end
  end

  describe "#successful?" do
    context "when status is :successful" do
      before { expect(subject).to receive(:status).and_return(:successful) }

      specify { expect(subject.successful?).to be true }
    end

    context "when status is not :successful" do
      before { expect(subject).to receive(:status).and_return(:failure) }

      specify { expect(subject.successful?).to be false }
    end
  end

  describe "#produced_at" do
    it "should query producedAt and return a Time object" do
      expect(subject.produced_at).to be == Time.parse('Sep 24 22:58:23 2015 GMT')
    end
  end
end

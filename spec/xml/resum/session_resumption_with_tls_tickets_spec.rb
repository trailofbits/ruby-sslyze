require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/resum/session_resumption_with_tls_tickets'

describe SSLyze::XML::Resum::SessionResumptionWithTLSTickets do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/resum/sessionResumptionWithTLSTickets' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#error" do
    context "when there is an 'error' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[@error]"))
      end

      it "should return the 'error' attribute" do
        pending "need an example with an 'error' attribute"

        expect(subject.error).to_not be_nil
      end
    end

    context "when there is no 'error' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@error)]"))
      end

      it { expect(subject.error).to be nil }
    end
  end

  describe "#error?" do
    context "when there is an 'error' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[@error]"))
      end

      it "should return the 'error' attribute" do
        pending "need an example with an 'error' attribute"

        expect(subject.error?).to be true
      end
    end

    context "when there is no 'error' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@error)]"))
      end

      it { expect(subject.error?).to be false }
    end
  end

  describe "#is_supported?" do
    context "when there is an 'isSupported' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[@isSupported]"))
      end

      it "should return the 'isSupported' attribute" do
        expect(subject.is_supported?).to be(true).or(be(false))
      end
    end

    context "when there is no 'isSupported' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@isSupported)]"))
      end

      it do
        pending "need an example with no 'isSupported' attribute"

        expect(subject.is_supported?).to be false
      end
    end
  end

  describe "#reason" do
    context "when there is a 'reason' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[@reason]"))
      end

      it " should return the 'reason' attribute" do
        expect(subject.reason).to be == "TLS ticket not assigned"
      end
    end

    context "when there is no 'reason' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@reason)]"))
      end

      it { expect(subject.reason).to be nil }
    end
  end

  describe "#to_s" do
    context "when there is a 'reason' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[@reason]"))
      end

      it "should return the reason" do
        expect(subject.to_s).to be == subject.reason
      end
    end

    context "when there is no 'reason' attribute" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@reason)]"))
      end

      it { expect(subject.to_s).to be == '' }
    end
  end
end

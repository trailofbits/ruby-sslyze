require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/resum'

describe SSLyze::XML::Resum do
  include_examples "XML specs"
  include_examples "Plugin element"

  let(:xpath) { '/document/results/target/resum' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#session_resumption_with_session_ids" do
    context "when the <sessionResumptionWithSessionIDs/> XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[sessionResumptionWithSessionIDs]"))
      end

      it do
        expect(subject.session_resumption_with_session_ids).to \
          be_kind_of(described_class::SessionResumptionWithSessionIDs)
      end
    end

    context "when the <sessionResumptionWithSessionIDs/> XML element is omitted" do
      pending "need an example with no <sessionResumptionWithSessionIDs/>"
    end
  end

  describe "#session_resumption_with_session_ids?" do
    context "when the <sessionResumptionWithSessionIDs/> XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[sessionResumptionWithSessionIDs]"))
      end

      it { expect(subject.session_resumption_with_session_ids?).to be true }
    end

    context "when the <sessionResumptionWithSessionIDs/> XML element is omitted" do
      pending "need an example with no <sessionResumptionWithSessionIDs/>"
    end
  end

  describe "#session_resumption_with_tls_tickets" do
    context "when the <sessionResumptionWithTLSTickets/> XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[sessionResumptionWithTLSTickets]"))
      end

      it do
        expect(subject.session_resumption_with_tls_tickets).to \
          be_kind_of(described_class::SessionResumptionWithTLSTickets)
      end
    end

    context "when the <sessionResumptionWithTLSTickets/> XML element is omitted" do
      pending "need an example with no <sessionResumptionWithTLSTickets/>"
    end
  end

  describe "#session_resumption_with_tls_tickets?" do
    context "when the <sessionResumptionWithTLSTickets/> XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[sessionResumptionWithTLSTickets]"))
      end

      it { expect(subject.session_resumption_with_tls_tickets?).to be true }
    end

    context "when the <sessionResumptionWithTLSTickets/> XML element is omitted" do
      pending "need an example with no <sessionResumptionWithTLSTickets/>"
    end
  end
end

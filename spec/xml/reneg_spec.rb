require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/reneg'

describe SSLyze::XML::Reneg do
  include_examples "XML specs"
  include_examples "Plugin element"

  let(:xpath) { '/document/results/target/reneg' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#session_renegotiation" do
    context "when the '<sessionRenegotiation/>' element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[sessionRenegotiation]"))
      end

      it do
        expect(subject.session_renegotiation).to be_kind_of(described_class::SessionRenegotiation)
      end
    end

    context "when the '<sessionRenegotiation/>' element is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(./sessionRenegotiation)]"))
      end

      it do
        expect(subject.session_renegotiation).to be nil
      end
    end
  end
end

require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/reneg'

describe SSLyze::XML::Reneg do
  include_examples "XML specs"
  include_examples "Plugin element"

  subject { described_class.new(xml.at('/document/results/target/reneg')) }

  describe "#session_renegotiation" do
    context "when the '<sessionRenegotiation/>' element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/reneg[sessionRenegotiation]'))
      end

      it do
        expect(subject.session_renegotiation).to be_kind_of(described_class::SessionRenegotiation)
      end
    end

    context "when the '<sessionRenegotiation/>' element is omitted" do
      pending "need an example where '<sessionRenegotiation/>' is omitted" do
        subject do
          described_class.new(xml.at('/document/results/target/reneg[not(./sessionRenegotiation)]'))
        end

        it { expect(subject.session_renegotiation).to be nil }
      end
    end
  end

  describe "#session_renegotiation?" do
    context "when the '<sessionRenegotiation/>' element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/reneg[sessionRenegotiation]'))
      end

      it do
        expect(subject.session_renegotiation?).to be true
      end
    end

    context "when the '<sessionRenegotiation/>' is omitted" do
      pending "need an example where '<sessionRenegotiation/>' is omitted" do
        subject do
          described_class.new(xml.at('/document/results/target/reneg[not(./sessionRenegotiation)]'))
        end

        it { expect(subject.session_renegotiation?).to be false }
      end
    end
  end
end

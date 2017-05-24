require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/http_headers'

describe SSLyze::XML::HTTPHeaders do
  include_examples "XML specs"
  include_examples "Plugin element"

  let(:xpath) { '/document/results/target/http_headers' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#http_strict_transport_security" do
    context "when the '<httpStrictTransportSecurity/>' XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[httpStrictTransportSecurity]"))
      end

      it do
        expect(subject.http_strict_transport_security).to \
          be_kind_of(described_class::HTTPStrictTransportSecurity)
      end
    end

    context "when the '<httpStrictTransportSecurity/>' XML element is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(./httpStrictTransportSecurity)]"))
      end

      it do
        pending "need an example with no '<httpStrictTransportSecurity/>'"

        expect(subject.http_strict_transport_security).to be nil
      end
    end
  end

  describe "#http_public_key_pinning" do
    context "when the '<httpPublicKeyPinning/>' XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[httpPublicKeyPinning]"))
      end

      it do
        expect(subject.http_public_key_pinning).to \
          be_kind_of(described_class::HTTPPublicKeyPinning)
      end
    end

    context "when the '<httpPublicKeyPinning/>' XML element is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(./httpPublicKeyPinning)]"))
      end

      it do
        pending "need an example with no '<httpPublicKeyPinning/>'"

        expect(subject.http_public_key_pinning).to be nil
      end
    end
  end
end

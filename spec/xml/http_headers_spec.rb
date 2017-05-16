require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/http_headers'

describe SSLyze::XML::HTTPHeaders do
  include_examples "XML specs"
  include_examples "Plugin element"

  subject { described_class.new(xml.at('/document/results/target/http_headers')) }

  describe "#http_strict_transport_security" do
    context "when the '<httpStrictTransportSecurity/>' XML element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers[httpStrictTransportSecurity]'))
      end

      it do
        expect(subject.http_strict_transport_security).to \
          be_kind_of(described_class::HTTPStrictTransportSecurity)
      end
    end

    context "when the '<httpStrictTransportSecurity/>' XML element is omitted" do
      pending "need an example with no '<httpStrictTransportSecurity/>'" do
        subject do
          described_class.new(xml.at('/document/results/target/http_headers[not(./httpStrictTransportSecurity)]'))
        end

        it do
          expect(subject.http_strict_transport_security).to be nil
        end
      end
    end
  end

  describe "#http_strict_transport_security?" do
    context "when the '<httpStrictTransportSecurity/>' XML element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers[httpStrictTransportSecurity]'))
      end

      it do
        expect(subject.http_strict_transport_security?).to be true
      end
    end

    context "when the '<httpStrictTransportSecurity/>' XML element is omitted" do
      pending "need an example with no '<httpStrictTransportSecurity/>'" do
        subject do
          described_class.new(xml.at('/document/results/target/http_headers[not(./httpStrictTransportSecurity)]'))
        end

        it do
          expect(subject.http_strict_transport_security?).to be false
        end
      end
    end
  end

  describe "#http_public_key_pinning" do
    context "when the '<httpPublicKeyPinning/>' XML element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers[httpPublicKeyPinning]'))
      end

      it do
        expect(subject.http_public_key_pinning).to \
          be_kind_of(described_class::HTTPPublicKeyPinning)
      end
    end

    context "when the '<httpPublicKeyPinning/>' XML element is omitted" do
      pending "need an example with no '<httpPublicKeyPinning/>'" do
        subject do
          described_class.new(xml.at('/document/results/target/http_headers[not(./httpPublicKeyPinning)]'))
        end

        it do
          expect(subject.http_public_key_pinning).to be nil
        end
      end
    end
  end

  describe "#http_public_key_pinning?" do
    context "when the '<httpPublicKeyPinning/>' XML element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers[httpPublicKeyPinning]'))
      end

      it do
        expect(subject.http_public_key_pinning?).to be true
      end
    end

    context "when the '<httpPublicKeyPinning/>' XML element is omitted" do
      pending "need an example with no '<httpPublicKeyPinning/>'" do
        subject do
          described_class.new(xml.at('/document/results/target/http_headers[not(./httpPublicKeyPinning)]'))
        end

        it do
          expect(subject.http_public_key_pinning?).to be false
        end
      end
    end
  end
end

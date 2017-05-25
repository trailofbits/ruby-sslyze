require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/http_headers/http_public_key_pinning'

describe SSLyze::XML::HTTPHeaders::HTTPPublicKeyPinning do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning'))
  end

  describe "#include_sub_domains?" do
    context "when the 'includeSubDomains' attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[@includeSubDomains]'))
      end

      it "should return the 'includeSubDomains' attribute" do
        expect(subject.include_sub_domains?).to be true
      end
    end

    context "when the 'includeSubDomains' attribute is not present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[not(@includeSubDomains)]'))
      end

      it { expect(subject.include_sub_domains?).to be nil }
    end
  end

  describe "#is_supported?" do
    context "when the 'isSupported' attribute is 'True'" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[@isSupported="True"]'))
      end

      it { expect(subject.is_supported?).to be true }
    end

    context "when the 'isSupported' attribute is 'False'" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[@isSupported="False"]'))
      end

      it { expect(subject.is_supported?).to be false }
    end
  end

  describe "#max_age" do
    context "when the 'maxAge' attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[@maxAge]'))
      end

      it "should return the 'maxAge' attribute" do
        expect(subject.max_age).to be 5184000
      end
    end

    context "when the 'maxAge' attribute is not present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpPublicKeyPinning[not(@maxAge)]'))
      end

      it { expect(subject.max_age).to be nil }
    end
  end
end

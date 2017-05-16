require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/http_headers/http_strict_transport_security'

describe SSLyze::XML::HTTPHeaders::HTTPStrictTransportSecurity do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity'))
  end

  describe "#include_sub_domains?" do
    context "when the 'includeSubDomains' attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[@includeSubDomains]'))
      end

      it "should return the 'includeSubDomains' attribute" do
        expect(subject.include_sub_domains?).to be true
      end
    end

    context "when the 'includeSubDomains' attribute is not present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[not(@includeSubDomains)]'))
      end

      it { expect(subject.include_sub_domains?).to be nil }
    end
  end

  describe "#is_supported?" do
    context "when the 'isSupported' attribute is 'True'" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[@isSupported="True"]'))
      end

      it { expect(subject.is_supported?).to be true }
    end

    context "when the 'isSupported' attribute is 'False'" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[@isSupported="False"]'))
      end

      it { expect(subject.is_supported?).to be false }
    end
  end

  describe "#max_age" do
    context "when the 'maxAge' attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[@maxAge]'))
      end

      it "should return the 'maxAge' attribute" do
        expect(subject.max_age).to be 31536000
      end
    end

    context "when the 'maxAge' attribute is not present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[not(@maxAge)]'))
      end

      it { expect(subject.max_age).to be nil }
    end
  end

  describe "#preload?" do
    context "when the 'preload' attribute is present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[@preload]'))
      end

      it "should return the 'preload' attribute" do
        expect(subject.preload?).to be true
      end
    end

    context "when the 'preload' attribute is not present" do
      subject do
        described_class.new(xml.at('/document/results/target/http_headers/httpStrictTransportSecurity[not(@preload)]'))
      end

      it { expect(subject.preload?).to be nil }
    end
  end
end

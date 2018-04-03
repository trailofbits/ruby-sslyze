require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/http_headers/http_strict_transport_security'

describe SSLyze::XML::HTTPHeaders::HTTPStrictTransportSecurity do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/http_headers/httpStrictTransportSecurity' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#include_sub_domains?" do
    context "when the 'includeSubDomains' attribute is present" do
      subject do
        described_class.new(xml.at("#{xpath}[@includeSubDomains]"))
      end

      it "should return a Boolean value" do
        expect(subject.include_sub_domains?).to be(true).or(be(false))
      end
    end

    context "when the 'includeSubDomains' attribute is not present" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@includeSubDomains)]"))
      end

      it do
        expect(subject.include_sub_domains?).to be nil
      end
    end
  end

  describe "#is_supported?" do
    context "when the 'isSupported' attribute is 'True'" do
      subject do
        described_class.new(xml.at("#{xpath}[@isSupported=\"True\"]"))
      end

      it { expect(subject.is_supported?).to be true }
    end

    context "when the 'isSupported' attribute is 'False'" do
      subject do
        described_class.new(xml.at("#{xpath}[@isSupported=\"False\"]"))
      end

      it do
        expect(subject.is_supported?).to be false
      end
    end
  end

  describe "#max_age" do
    context "when the 'maxAge' attribute is present" do
      subject do
        described_class.new(xml.at("#{xpath}[@maxAge]"))
      end

      it "should return the 'maxAge' attribute" do
        expect(subject.max_age).to be > 0
      end
    end

    context "when the 'maxAge' attribute is not present" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@maxAge)]"))
      end

      it do
        expect(subject.max_age).to be nil
      end
    end
  end

  describe "#preload?" do
    context "when the 'preload' attribute is present" do
      subject do
        described_class.new(xml.at("#{xpath}[@preload]"))
      end

      it "should return a Boolean value" do
        expect(subject.preload?).to be(true).or(be(false))
      end
    end

    context "when the 'preload' attribute is not present" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@preload)]"))
      end

      it do
        expect(subject.preload?).to be nil
      end
    end
  end
end

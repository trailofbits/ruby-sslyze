require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/http_headers/http_public_key_pinning'

describe SSLyze::XML::HTTPHeaders::HTTPPublicKeyPinning do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/http_headers/httpPublicKeyPinning' }

  subject do
    described_class.new(xml.at(xpath))
  end

  describe "#include_sub_domains?" do
    context "when the 'includeSubDomains' attribute is present" do
      let(:xpath) { "#{super()}[@includeSubDomains]" }

      context "and it is 'True'" do
        let(:xpath) { "#{super()}[@includeSubDomains='True']" }

        it do
          pending "find domain where includeSubDomains='True'"

          expect(subject.include_sub_domains?).to be(true)
        end
      end

      context "but it is 'False'" do
        let(:xpath) { "#{super()}[@includeSubDomains='False']" }

        it do
          expect(subject.include_sub_domains?).to be(false)
        end
      end
    end

    context "when the 'includeSubDomains' attribute is not present" do
      let(:xpath) { "#{super()}[not(@includeSubDomains)]" }

      it { expect(subject.include_sub_domains?).to be nil }
    end
  end

  describe "#is_supported?" do
    context "when the 'isSupported' attribute is 'True'" do
      let(:xpath) { "#{super()}[@isSupported='True']" }

      it { expect(subject.is_supported?).to be true }
    end

    context "when the 'isSupported' attribute is 'False'" do
      let(:xpath) { "#{super()}[@isSupported='False']" }

      it { expect(subject.is_supported?).to be false }
    end
  end

  describe "#max_age" do
    context "when the 'maxAge' attribute is present" do
      let(:xpath) { "#{super()}[@maxAge]" }

      it "should return the 'maxAge' attribute" do
        expect(subject.max_age).to be > 0
      end
    end

    context "when the 'maxAge' attribute is not present" do
      let(:xpath) { "#{super()}[not(@maxAge)]" }

      it { expect(subject.max_age).to be nil }
    end
  end
end

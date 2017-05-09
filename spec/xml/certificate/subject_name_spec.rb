require 'spec_helper'
require 'sslyze/xml/certificate/domain_name'

describe SSLyze::XML::Certificate::DomainName do
  let(:name) { 'twitter.com' }

  subject { described_class.new(name) }

  describe "#==" do
    context "when the domain names are the same" do
      let(:other) { described_class.new(name) }

      it "should return true" do
        expect(subject == other).to be true
      end
    end

    context "when the domain names are different" do
      let(:other) { described_class.new(name + 'XXX') }

      it "should return true" do
        expect(subject == other).to be false
      end
    end
  end

  describe "#include?" do
    context "when the domain name is literal" do
      it "should compare the given domain to the domain name" do
        expect(subject.include?(name)).to be true
      end
    end

    context "when the domain name has a wildcard" do
      let(:wildcard) { "*.#{name}" }

      subject { described_class.new(wildcard) }

      it "should match the domain" do
        expect(subject.include?(name)).to be true
      end

      it "should match any sub-domain" do
        expect(subject.include?("foo.#{name}")).to be true
      end
    end
  end

  describe "#to_s" do
    it "should return the domain name" do
      expect(subject.to_s).to be name
    end
  end

  describe "#to_str" do
    it "should return the domain name" do
      expect(subject.to_str).to be name
    end
  end

  describe "#inspect" do
    subject { super().inspect }

    it "should include the class name" do
      expect(subject).to include(described_class.name)
    end

    it "should include the domain name" do
      expect(subject).to include(name)
    end
  end
end

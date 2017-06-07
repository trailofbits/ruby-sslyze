require 'spec_helper'
require 'sslyze/x509/domain'

describe SSLyze::X509::Domain do
  let(:domain_name)   { 'example.com'      }
  let(:wildcard_name) { "*.#{domain_name}" }

  subject { described_class.new(domain_name) }

  describe "#initialize" do
    context "when given a fully qualified domain name" do
      subject { described_class.new(domain_name) }

      it "should set #name" do
        expect(subject.name).to be == domain_name
      end

      it "should not set #suffix" do
        expect(subject.suffix).to be nil
      end

      it "should not set #domain to #name" do
        expect(subject.domain).to be == domain_name
      end
    end

    context "when given a wildcard domain name" do
      subject { described_class.new(wildcard_name) }

      it "should set #name" do
        expect(subject.name).to be == wildcard_name
      end

      it "should set #suffix" do
        expect(subject.suffix).to be == ".#{domain_name}"
      end

      it "should set #domain" do
        expect(subject.domain).to be == domain_name
      end
    end
  end

  describe "#==" do
    context "when given another #{described_class}" do
      subject { described_class.new(domain_name) }

      context "and it matches the domain name" do
        let(:other) { described_class.new(domain_name) }

        it { expect(subject == other).to be true }
      end

      context "but it doesn't match" do
        let(:other) { described_class.new('foo.com') }

        it { expect(subject == other).to be false }
      end
    end

    context "when given a non-#{described_class}" do
      let(:other) { Object.new }

      subject { described_class.new(domain_name) }

      it "should return false" do
        expect(subject == other).to be false
      end
    end
  end

  describe "#include?" do
    context "when given another #{described_class}" do
      context "when the other domain name is fully qualified" do
        subject { described_class.new(domain_name) }

        context "and it matches the domain name" do
          it { expect(subject.include?(domain_name)).to be true }
        end

        context "but it doesn't match" do
          it { expect(subject.include?('foo.com')).to be false }
        end
      end

      context "when the other domain name is a wildcard" do
        subject { described_class.new(wildcard_name) }

        context "and it matches the wildcard domain name" do
          it { expect(subject.include?(wildcard_name)).to be true }
        end

        context "and shares the same domain name" do
          it { expect(subject.include?(domain_name)).to be true }
        end

        context "and it is a subdomain of the wildcard domain name" do
          it { expect(subject.include?("foo.#{domain_name}")).to be true }
        end

        context "but it doesn't match" do
          it { expect(subject.include?("foo.com")).to be false }
        end
      end
    end
  end

  describe "#to_s" do
    it "should return the #name" do
      expect(subject.to_s).to be subject.name
    end
  end

  describe "#to_str" do
    it "should return the #name" do
      expect(subject.to_str).to be subject.name
    end
  end

  describe "#inspect" do
    it "should include the class name and #name" do
      expect(subject.inspect).to be == "#<#{described_class}: #{subject.name}>"
    end
  end
end

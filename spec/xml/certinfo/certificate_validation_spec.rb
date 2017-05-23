require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate_validation'

describe SSLyze::XML::Certinfo::CertificateValidation do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/certinfo/certificateValidation'))
  end

  describe "#hostname_validation" do
    it do
      expect(subject.hostname_validation).to be_kind_of(described_class::HostnameValidation)
    end
  end

  describe "#each_path_validation" do
    it "should yield successive PathValidation objects" do
      expect { |b|
        subject.each_path_validation(&b)
      }.to yield_successive_args(
        described_class::PathValidation,
        described_class::PathValidation,
        described_class::PathValidation,
        described_class::PathValidation,
        described_class::PathValidation
      )
    end
  end

  describe "#path_validations" do
    subject { super().path_validations }

    it do
      expect(subject).to_not be_empty
      expect(subject).to all(be_kind_of(described_class::PathValidation))
    end
  end
end

require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/compression'

describe SSLyze::XML::Compression do
  include_examples "XML specs"
  include_examples "Plugin element"

  subject { described_class.new(xml.at('/document/results/target/compression')) }

  describe "#compression_method" do
    it do
      expect(subject.compression_method).to be_kind_of(described_class::CompressionMethod)
    end
  end

  describe "#is_supported?" do
    it "should call compression_method.is_supported?" do
      expect(subject.is_supported?).to be == subject.compression_method.is_supported?
    end
  end
end

require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/compression'

describe SSLyze::XML::Compression do
  include_examples "XML specs"
  include_examples "Plugin element"

  let(:xpath) { '/document/results/target/compression' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#deflate" do
    it do
      expect(subject.deflate).to be_kind_of(described_class::CompressionMethod)
    end

    it "should parse the DEFLATE compressionMethod" do
      expect(subject.deflate.type).to be :DEFLATE
    end
  end
end

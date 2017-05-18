require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/compression/compression_method'

describe SSLyze::XML::Compression::CompressionMethod do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/compression/compressionMethod'))
  end

  describe "#is_supported??" do
    it "should prase the 'isSupported' attribute" do
      expect(subject.is_supported?).to be(true).or(be(false))
    end
  end

  describe "#type" do
    it "should parse the 'type' attribute" do
      expect(subject.type).to be :DEFLATE
    end
  end
end

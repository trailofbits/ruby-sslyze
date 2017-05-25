require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/heartbleed/openssl_heartbleed'

describe SSLyze::XML::Heartbleed::OpenSSLHeartbleed do
  include_examples "XML specs"

  subject do
    described_class.new(xml.at('/document/results/target/heartbleed/openSslHeartbleed'))
  end

  describe "#is_vulnerable?" do
    it "should prase the 'isVulnerable' attribute" do
      expect(subject.is_vulnerable?).to be(true).or(be(false))
    end
  end
end

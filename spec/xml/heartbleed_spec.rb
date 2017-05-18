require 'spec_helper'
require 'xml_examples'
require 'xml/plugin_examples'
require 'sslyze/xml/heartbleed'

describe SSLyze::XML::Heartbleed do
  include_examples "XML specs"
  include_examples "Plugin element"

  subject { described_class.new(xml.at('/document/results/target/heartbleed')) }

  describe "#openssl_heartbleed" do
    context "when the '<openSslHeartbleed/>' XML element is present" do
      subject do
        described_class.new(xml.at('/document/results/target/heartbleed[openSslHeartbleed]'))
      end

      it do
        expect(subject.openssl_heartbleed).to be_kind_of(described_class::OpenSSLHeartbleed)
      end
    end

    context "when the '<openSslHeartbleed/>' XML element is missing" do
      subject do
        described_class.new(xml.at('/document/results/target/heartbleed[not(./openSslHeartbleed)]'))
      end

      it { expect(subject.openssl_heartbleed).to be nil }
    end
  end
end

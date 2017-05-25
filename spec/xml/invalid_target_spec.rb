require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/invalid_target'

describe SSLyze::XML::InvalidTarget do
  include_examples "XML specs"

  let(:xpath) { '/document/invalidTargets/invalidTarget' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#host" do
    it "must parse the host attribute" do
      expect(subject.host).to be == 'foo'
    end
  end

  describe "#error" do
    it "must parse the ip attribute" do
      expect(subject.error).to be == 'Could not resolve foo'
    end
  end
end

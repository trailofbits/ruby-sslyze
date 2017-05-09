require 'spec_helper'
require 'xml_examples'
require 'sslyze/invalid_target'

describe SSLyze::InvalidTarget do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/invalidTargets/invalidTarget')) }

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

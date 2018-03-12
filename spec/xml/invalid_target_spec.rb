require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/invalid_target'

describe SSLyze::XML::InvalidTarget do
  include_examples "XML specs"

  let(:host)   { 'foo'             }
  let(:port)   { 443               }
  let(:target) { "#{host}:#{port}" }
  let(:xpath)  { "/document/invalidTargets/invalidTarget[text()='#{target}']" }

  subject { described_class.new(xml.at(xpath)) }

  describe "#target" do
    it "must return the target text" do
      expect(subject.target).to be == target
    end
  end

  describe "#host" do
    it "must return the host component of the target" do
      expect(subject.host).to be == host
    end
  end

  describe "#port" do
    it "must return the port component of the target" do
      expect(subject.port).to be port
    end
  end

  describe "#error" do
    it "must parse the ip attribute" do
      expect(subject.error).to be == 'Could not resolve hostname'
    end
  end
end

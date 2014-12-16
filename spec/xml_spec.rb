require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml'

describe SSLyze::XML do
  include_examples "XML specs"

  describe ".parse" do
    it "should parse the contents of the file" do
    end
  end

  describe ".open" do
    it "should open the XML file" do
    end
  end

  describe "#version" do
    it "must parse the SSLyzeVersion attribute" do
      expect(subject.version).to be == "v0.10"
    end
  end

  describe "#default_timeout" do
    it "must parse the defaultTimeout attribute" do
      expect(subject.default_timeout).to be == 5
    end
  end

  describe "#https_tunnel" do
    it "must parse the httpsTunnel attribute" do
      expect(subject.https_tunnel).to be nil
    end
  end

  describe "#start_tls" do
    it "must parse the startTLS attribute" do
      expect(subject.start_tls).to be nil
    end
  end

  describe "#total_scan_time" do
    it "must parse the totalScanTime attribute" do
      expect(subject.total_scan_time).to be_kind_of(Float)
      expect(subject.total_scan_time).to be > 0.0
    end
  end

  describe "#invalid_targets" do
    pending "need data"
  end

  describe "#each_target" do
    it "should iterate over each target element under results" do
      expect { |b| subject.each_target(&b) }.to yield_successive_args(Target, Target)
    end
  end

  describe "#targets" do
    it "should return an Array of Targets" do
      expect(subject.targets).to be_an(Array).and(all(be_a(Target)))
    end
  end

  describe "#target" do
    it "should return the first target" do
      expect(subject.target.host).to be == subject.targets.first.host
    end
  end
end

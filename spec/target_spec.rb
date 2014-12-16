require 'spec_helper'
require 'xml_examples'
require 'sslyze/target'

describe SSLyze::Target do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target')) }

  describe "#host" do
    it "must parse the host attribute" do
      expect(subject.host).to be == 'github.com'
    end
  end

  describe "#ip" do
    it "must parse the ip attribute" do
      expect(subject.ip).to be == '192.30.252.131'
    end
  end

  describe "#port" do
    it "must parse the port attribute" do
      expect(subject.port).to be == 443
    end
  end

  describe "#cert_info" do
    it "must return a CertInfo object" do
      expect(subject.cert_info).to be_kind_of(CertInfo)
    end
  end

  describe "#compression" do
    it "must parse the compressionMethod elements into a Hash" do
      expect(subject.compression).to be == {deflate: false}
    end
  end

  describe "#heartbleed?" do
    it "must query isVulnerable attribute within heartbleed" do
      expect(subject.heartbleed?).to be == false
    end
  end

  describe "#client_initiated_session_renegotiation?" do
    it "should check canBeClientInitiated and !isSecure" do
      expect(subject.client_initiated_session_renegotiation?).to be(false)
    end
  end

  describe "#sslv2" do
    it "must return a Protocol object" do
      expect(subject.sslv2).to be_kind_of(Protocol)
    end
  end

  describe "#sslv3" do
    it "must return a Protocol object" do
      expect(subject.sslv3).to be_kind_of(Protocol)
    end
  end

  describe "#tlsv1" do
    it "must return a Protocol object" do
      expect(subject.tlsv1).to be_kind_of(Protocol)
    end
  end

  describe "#tlsv1_1" do
    it "must return a Protocol object" do
      expect(subject.tlsv1_1).to be_kind_of(Protocol)
    end
  end

  describe "#tlsv1_2" do
    it "must return a Protocol object" do
      expect(subject.tlsv1_2).to be_kind_of(Protocol)
    end
  end

end

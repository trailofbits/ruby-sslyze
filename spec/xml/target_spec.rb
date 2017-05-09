require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/target'

describe SSLyze::XML::Target do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target')) }

  describe "#host" do
    it "must parse the host attribute" do
      expect(subject.host).to be == 'github.com'
    end
  end

  describe "#ip" do
    it "must parse the ip attribute" do
      expect(subject.ip).to be == '192.30.255.112'
    end
  end

  describe "#port" do
    it "must parse the port attribute" do
      expect(subject.port).to be == 443
    end
  end

  describe "#cert_info" do
    it "must return a CertInfo object" do
      expect(subject.cert_info).to be_kind_of(XML::CertInfo)
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

  describe "#session_renegotiation" do
    it "should return a SessionRenegotiation object" do
      expect(subject.session_renegotiation).to be_kind_of(described_class::SessionRenegotiation)
    end

    it "should parse the canBeClientInitiated attribute" do
      expect(subject.session_renegotiation.client_initiated).to be(false)
    end

    it "should parse the isSecure attribute" do
      expect(subject.session_renegotiation.secure).to be(true)
    end
  end

  describe "#sslv2" do
    it "must return a Protocol object" do
      expect(subject.sslv2).to be_kind_of(XML::Protocol)
    end
  end

  describe "#sslv3" do
    it "must return a Protocol object" do
      expect(subject.sslv3).to be_kind_of(XML::Protocol)
    end
  end

  describe "#tlsv1" do
    it "must return a Protocol object" do
      expect(subject.tlsv1).to be_kind_of(XML::Protocol)
    end
  end

  describe "#tlsv1_1" do
    it "must return a Protocol object" do
      expect(subject.tlsv1_1).to be_kind_of(XML::Protocol)
    end
  end

  describe "#tlsv1_2" do
    it "must return a Protocol object" do
      expect(subject.tlsv1_2).to be_kind_of(XML::Protocol)
    end
  end

  describe "#each_ssl_protocol" do
    context "when a block is given" do
      it "should yield sslv2 and sslv3" do
        expect { |b|
          subject.each_ssl_protocol(&b)
        }.to yield_successive_args(subject.sslv2, subject.sslv3)
      end
    end

    context "when no block is given" do
      it "should return an Enumerator" do
        expect(subject.each_ssl_protocol).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#ssl_protocols" do
    it "should return sslv2 and sslv3" do
      expect(subject.ssl_protocols).to be == [subject.sslv2, subject.sslv3]
    end
  end

  describe "#each_tls_protocol" do
    context "when a block is given" do
      it "should yield tlsv1, tlsv1_1 and tlsv1_2" do
        expect { |b|
          subject.each_tls_protocol(&b)
        }.to yield_successive_args(
          subject.tlsv1,
          subject.tlsv1_1,
          subject.tlsv1_2
        )
      end
    end

    context "when no block is given" do
      it "should return an Enumerator" do
        expect(subject.each_tls_protocol).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#tls_protocols" do
    it "should return tlsv1, tlsv1_1 and tlsv1_2" do
      expect(subject.tls_protocols).to be == [
        subject.tlsv1,
        subject.tlsv1_1,
        subject.tlsv1_2
      ]
    end
  end

  describe "#each_protocol" do
    context "when a block is given" do
      it "should yield sslv2, sslv3, tlsv1, tlsv1_1 and tlsv1_2" do
        expect { |b|
          subject.each_protocol(&b)
        }.to yield_successive_args(
          subject.sslv2,
          subject.sslv3,
          subject.tlsv1,
          subject.tlsv1_1,
          subject.tlsv1_2
        )
      end
    end

    context "when no block is given" do
      it "should return an Enumerator" do
        expect(subject.each_protocol).to be_kind_of(Enumerator)
      end
    end
  end

  describe "#protocols" do
    it "should return sslv2, sslv3, tlsv1, tlsv1_1 and tlsv1_2" do
      expect(subject.protocols).to be == [
        subject.sslv2,
        subject.sslv3,
        subject.tlsv1,
        subject.tlsv1_1,
        subject.tlsv1_2
      ]
    end
  end

end

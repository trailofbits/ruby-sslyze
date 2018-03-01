require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/target'

describe SSLyze::XML::Target do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#host" do
    let(:expected_host) { 'twitter.com' }

    let(:xpath) { "#{super()}[@host='#{expected_host}']" }

    it "must parse the host attribute" do
      expect(subject.host).to be == expected_host
    end
  end

  describe "#ip" do
    let(:expected_ip) { '192.30.255.113' }

    let(:xpath) { "#{super()}[@ip='#{expected_ip}']" }

    it "must parse the ip attribute" do
      expect(subject.ip).to be == expected_ip
    end
  end

  describe "#ipaddr" do
    let(:expected_ip) { '192.30.255.113' }
    let(:xpath) { "#{super()}[@ip='#{expected_ip}']" }

    it "must parse the ip attribute" do
      expect(subject.ipaddr).to be == IPAddr.new(expected_ip)
    end
  end

  describe "#port" do
    it "must parse the port attribute" do
      expect(subject.port).to be == 443
    end
  end

  describe "#certinfo" do
    it do
      expect(subject.certinfo).to be_kind_of(SSLyze::XML::Certinfo)
    end
  end

  describe "#compression" do
    context "when the 'compression' XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[compression]"))
      end

      it do
        expect(subject.compression).to be_kind_of(SSLyze::XML::Compression)
      end
    end

    context "when the 'compression' XML element is missing" do
      subject do
        described_class.new(xml.at("#{xpath}[not(compression)]"))
      end

      it do
        pending "need an example where 'compression' is missing"

        expect(subject.compression).to be nil
      end
    end
  end

  describe "#heartbleed" do
    context "when the 'heartbleed' XML element is present" do
      subject do
        described_class.new(xml.at("#{xpath}[heartbleed]"))
      end

      it do
        expect(subject.heartbleed).to be_kind_of(SSLyze::XML::Heartbleed)
      end
    end

    context "when the 'heartbleed' XML element is missing" do
      subject do
        described_class.new(xml.at("#{xpath}[not(heartbleed)]"))
      end

      it do
        pending "need an example without the 'heartbleed' XML element"

        expect(subject.heartbleed).to be nil
      end
    end
  end

  describe "#reneg" do
    it "should return a Reneg object" do
      expect(subject.reneg).to be_kind_of(SSLyze::XML::Reneg)
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

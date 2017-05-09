require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certificate'

describe SSLyze::XML::Certificate::SubjectPublicKeyInfo do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain/certificate/subjectPublicKeyInfo')) }

  describe "#public_key" do
    it "should return a PublicKey object" do
      expect(subject.public_key).to be_a(XML::Certificate::PublicKey)
    end

    it "should parse the publicKey/modulus element" do
      expect(subject.public_key.modulus).to be == %{00:b1:d4:dc:3c:af:fd:f3:4e:ed:c1:67:ad:e6:cb:22:e8:b7:e2:ab:28:f2:f7:dc:62:70:08:d1:0c:af:d6:16:6a:21:b0:36:4b:17:0d:36:63:04:ae:bf:ea:20:51:95:65:66:f2:bf:b9:4d:a4:0c:29:eb:f5:15:b1:e8:35:b3:70:10:94:d5:1b:59:b4:26:0f:d6:83:57:59:9d:e1:7c:09:dd:e0:13:ca:4d:6f:43:9b:cd:cf:87:3a:15:a7:85:dd:66:83:ed:93:0c:fe:2b:6d:38:1c:79:88:90:cf:ad:58:18:2d:51:d1:c2:a3:f2:47:8c:6f:38:09:b9:b8:ef:4c:93:0b:cb:83:94:87:ea:e0:a3:b5:d9:7b:9b:6b:0f:43:f9:ca:ee:80:0d:28:a7:76:f1:25:f4:c1:35:3c:f6:74:ad:de:6a:33:82:7b:dc:fd:4b:76:a7:c2:ee:f2:6a:bf:a9:24:a6:5f:e7:2e:7c:0e:db:c3:74:73:fa:7e:c6:d8:cf:60:eb:36:56:21:b6:c1:8a:b8:24:82:4d:78:24:ba:e9:1d:a1:8a:a7:87:be:66:25:69:bf:be:3b:72:6e:4f:e0:e4:85:25:08:b1:91:89:b8:d6:74:65:76:9b:2c:4f:62:1f:a1:fa:3a:be:9c:24:bf:9f:ca:b0:c5:c0:67:8d}
    end

    it "should parse the publicKey/exponent element" do
      expect(subject.public_key.exponent).to be == 65537
    end
  end

  describe "#public_key_algorithm" do
    it "should parse the publicKeyAlgorithm element" do
      expect(subject.public_key_algorithm).to be == 'rsaEncryption'
    end
  end

  describe "#public_key_size" do
    it "should parse the publicKeySize element" do
      expect(subject.public_key_size).to be == 2048
    end
  end
end

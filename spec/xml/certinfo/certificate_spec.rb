require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate'

describe SSLyze::XML::Certinfo::Certificate do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/receivedCertificateChain/certificate' }

  subject { described_class.new(xml.at(xpath)) }

  describe "#position" do
    context "when the 'position' attribute is set" do
      subject do
        described_class.new(xml.at("#{xpath}[@position]"))
      end

      it "should parse the position attribute" do
        pending "need an example with the 'position' attribute set"

        expect(subject.position).to be :leaf
      end
    end

    context "when the 'position' attribute is omitted" do
      subject do
        described_class.new(xml.at("#{xpath}[not(@position)]"))
      end

      it { expect(subject.position).to be nil }
    end
  end

  describe "#sha1_fingerprint" do
    let(:expected_sha1) { 'd79f076110b39293e349ac89845b0380c19e2f8b' }

    let(:xpath) { "#{super()}[@sha1Fingerprint='#{expected_sha1}']" }

    it "should parse the 'sha1Fingerprint' attribute" do
      expect(subject.sha1_fingerprint).to be == expected_sha1
    end
  end

  describe "#hpkp_sha256_pin" do
    let(:expected_hpkp_sha256) { 'pL1+qb9HTMRZJmuC/bB/ZI9d302BYrrqiVuRyW+DGrU=' }

    let(:xpath) { "#{super()}[@hpkpSha256Pin='#{expected_hpkp_sha256}']" }

    it "should parse the 'hpkpSha256Pin' attribute" do
      expect(subject.hpkp_sha256_pin).to be == expected_hpkp_sha256
    end
  end

  describe "#as_pem" do
    let(:host) { 'github.com' }
    let(:host_pem) do
%{-----BEGIN CERTIFICATE-----
MIIHeTCCBmGgAwIBAgIQC/20CQrXteZAwwsWyVKaJzANBgkqhkiG9w0BAQsFADB1
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMTQwMgYDVQQDEytEaWdpQ2VydCBTSEEyIEV4dGVuZGVk
IFZhbGlkYXRpb24gU2VydmVyIENBMB4XDTE2MDMxMDAwMDAwMFoXDTE4MDUxNzEy
MDAwMFowgf0xHTAbBgNVBA8MFFByaXZhdGUgT3JnYW5pemF0aW9uMRMwEQYLKwYB
BAGCNzwCAQMTAlVTMRkwFwYLKwYBBAGCNzwCAQITCERlbGF3YXJlMRAwDgYDVQQF
Ewc1MTU3NTUwMSQwIgYDVQQJExs4OCBDb2xpbiBQIEtlbGx5LCBKciBTdHJlZXQx
DjAMBgNVBBETBTk0MTA3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5p
YTEWMBQGA1UEBxMNU2FuIEZyYW5jaXNjbzEVMBMGA1UEChMMR2l0SHViLCBJbmMu
MRMwEQYDVQQDEwpnaXRodWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA54hc8pZclxgcupjiA/F/OZGRwm/ZlucoQGTNTKmBEgNsrn/mxhngWmPw
bAvUaLP//T79Jc+1WXMpxMiz9PK6yZRRFuIo0d2bx423NA6hOL2RTtbnfs+y0PFS
/YTpQSelTuq+Fuwts5v6aAweNyMcYD0HBybkkdosFoDccBNzJ92Ac8I5EVDUc3Or
/4jSyZwzxu9kdmBlBzeHMvsqdH8SX9mNahXtXxRpwZnBiUjw36PgN+s9GLWGrafd
02T0ux9Yzd5ezkMxukqEAQ7AKIIijvaWPAJbK/52XLhIy2vpGNylyni/DQD18bBP
T+ZG1uv0QQP9LuY/joO+FKDOTler4wIDAQABo4IDejCCA3YwHwYDVR0jBBgwFoAU
PdNQpdagre7zSmAKZdMh1Pj41g8wHQYDVR0OBBYEFIhcSGcZzKB2WS0RecO+oqyH
IidbMCUGA1UdEQQeMByCCmdpdGh1Yi5jb22CDnd3dy5naXRodWIuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwdQYDVR0f
BG4wbDA0oDKgMIYuaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItZXYtc2Vy
dmVyLWcxLmNybDA0oDKgMIYuaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTIt
ZXYtc2VydmVyLWcxLmNybDBLBgNVHSAERDBCMDcGCWCGSAGG/WwCATAqMCgGCCsG
AQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAcGBWeBDAEBMIGI
BggrBgEFBQcBAQR8MHowJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0
LmNvbTBSBggrBgEFBQcwAoZGaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0Rp
Z2lDZXJ0U0hBMkV4dGVuZGVkVmFsaWRhdGlvblNlcnZlckNBLmNydDAMBgNVHRMB
Af8EAjAAMIIBfwYKKwYBBAHWeQIEAgSCAW8EggFrAWkAdgCkuQmQtBhYFIe7E6LM
Z3AKPDWYBPkb37jjd80OyA3cEAAAAVNhieoeAAAEAwBHMEUCIQCHHSEY/ROK2/sO
ljbKaNEcKWz6BxHJNPOtjSyuVnSn4QIgJ6RqvYbSX1vKLeX7vpnOfCAfS2Y8lB5R
NMwk6us2QiAAdgBo9pj4H2SCvjqM7rkoHUz8cVFdZ5PURNEKZ6y7T0/7xAAAAVNh
iennAAAEAwBHMEUCIQDZpd5S+3to8k7lcDeWBhiJASiYTk2rNAT26lVaM3xhWwIg
NUqrkIODZpRg+khhp8ag65B8mu0p4JUAmkRDbiYnRvYAdwBWFAaaL9fC7NP14b1E
sj7HRna5vJkRXMDvlJhV1onQ3QAAAVNhieqZAAAEAwBIMEYCIQDnm3WStlvE99GC
izSx+UGtGmQk2WTokoPgo1hfiv8zIAIhAPrYeXrBgseA9jUWWoB4IvmcZtshjXso
nT8MIG1u1zF8MA0GCSqGSIb3DQEBCwUAA4IBAQCLbNtkxuspqycq8h1EpbmAX0wM
5DoW7hM/FVdz4LJ3Kmftyk1yd8j/PSxRrAQN2Mr/frKeK8NE1cMji32mJbBqpWtK
/+wC+avPplBUbNpzP53cuTMF/QssxItPGNP5/OT9Aj1BxA/NofWZKh4ufV7cz3pY
RDS4BF+EEFQ4l5GY+yp4WJA/xSvYsTHWeWxRD1/nl62/Rd9FN2NkacRVozCxRVle
FrBHTFxqIP6kDnxiLElBrZngtY07ietaYZVLQN/ETyqLQftsf8TecwTklbjvm8NT
JqbaIVifYwqwNN+4lRxS3F5lNlA/il12IOgbRioLI62o8G0DaEUQgHNf8vSG
-----END CERTIFICATE-----
}
    end

    let(:xpath) { "/document/results/target[@host='#{host}']/certinfo/receivedCertificateChain/certificate" }

    it "should parse the asPEM element" do
      expect(subject.as_pem).to be == host_pem
    end
  end

  describe "#x509" do
    it do
      expect(subject.x509).to be_kind_of(OpenSSL::X509::Certificate)
    end
  end

  describe "#extensions" do
    it do
      expect(subject.extensions).to be_kind_of(SSLyze::X509::ExtensionSet)
    end
  end

  describe "#issuer" do
    it do
      expect(subject.issuer).to be_a(SSLyze::X509::Name)
    end
  end

  describe "#not_after" do
    it do
      expect(subject.not_after).to be_kind_of(Time)
    end
  end

  describe "#not_before" do
    it do
      expect(subject.not_before).to be_kind_of(Time)
    end
  end

  describe "#public_key" do
    it do
      expect(subject.public_key).to be_a(OpenSSL::PKey::RSA)
    end
  end

  describe "#serial" do
    it do
      expect(subject.serial).to be_a(OpenSSL::BN)
    end
  end

  describe "#signature_algorithm" do
    it do
      expect(subject.signature_algorithm).to be == 'sha256WithRSAEncryption'
    end
  end

  describe "#subject" do
    it do
      expect(subject.subject).to be_a(SSLyze::X509::Name)
    end
  end

  describe "#version" do
    it do
      expect(subject.version).to be 2
    end
  end

  describe "#==" do
    context "when the #as_pem matches" do
      let(:other) { described_class.new(xml.at("#{xpath}[1]")) }

      it { expect(subject == other).to be true }
    end

    context "when the #as_pem do not match" do
      let(:other) { described_class.new(xml.at("#{xpath}[2]")) }

      it { expect(subject == other).to be false }
    end

    context "when the classes do not match" do
      let(:other) { Object.new }

      it { expect(subject == other).to be false }
    end
  end
end

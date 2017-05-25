require 'spec_helper'
require 'xml_examples'
require 'sslyze/xml/certinfo/certificate'

describe SSLyze::XML::Certinfo::Certificate do
  include_examples "XML specs"

  let(:xpath) { '/document/results/target/certinfo/certificateValidation/pathValidation/verifiedCertificateChain/certificate' }

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
    it "should parse the 'sha1Fingerprint' attribute" do
      expect(subject.sha1_fingerprint).to be == '235a79b3270d790505e0bea2cf5c149f9038821b'
    end
  end

  describe "#hpkp_sha256_pin" do
    it "should parse the 'hpkpSha256Pin' attribute" do
      expect(subject.hpkp_sha256_pin).to be == 'PS12nvydU5dSxolqCn3V11wWF5Z12JRhXT2dhyawT4M='
    end
  end

  describe "#as_pem" do
    it "should parse the asPEM element" do
      expect(subject.as_pem).to be == %{-----BEGIN CERTIFICATE-----
MIIHnTCCBoWgAwIBAgIQB3a13cqDpLnKWY9ddx+eRjANBgkqhkiG9w0BAQsFADB1
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMTQwMgYDVQQDEytEaWdpQ2VydCBTSEEyIEV4dGVuZGVk
IFZhbGlkYXRpb24gU2VydmVyIENBMB4XDTE2MDMwOTAwMDAwMFoXDTE4MDMxNDEy
MDAwMFowggEhMR0wGwYDVQQPDBRQcml2YXRlIE9yZ2FuaXphdGlvbjETMBEGCysG
AQQBgjc8AgEDEwJVUzEZMBcGCysGAQQBgjc8AgECEwhEZWxhd2FyZTEQMA4GA1UE
BRMHNDMzNzQ0NjESMBAGA1UECRMJU3VpdGUgOTAwMRcwFQYDVQQJEw4xMzU1IE1h
cmtldCBTdDEOMAwGA1UEERMFOTQxMDMxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpD
YWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNpc2NvMRYwFAYDVQQKEw1Ud2l0
dGVyLCBJbmMuMRkwFwYDVQQLExBUd2l0dGVyIFNlY3VyaXR5MRQwEgYDVQQDEwt0
d2l0dGVyLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMIImPpn
AAVVtgthDhrXtYrBzAO+PBf7lPfZ+kyfRmCcaq19OuU0WhKwsguq7JbhWIEvrWCr
R5Np44R1U8H5D7lGq57qqxiYjGhUCFFlQxphlydcXg8V6c0Wq91RW3Yv/NMRmZ3S
pj2HAnXmJJbiBD4UnPp+uHFCNwC1sIriM5WL2j/7Y003YtUcAuowftwNU9XUC7ij
EBNtH4mUC2qURGcpgq3m1bBS/JVXBtbRImaE05IqAseUVt9VP8IT8nwWeDOhU/d3
l1y3lgXVRPS/74MiXXrmj+Ss3zSetg8KU/Aa23E3aZL2FKkcdWVyRSQJOyxq17lp
pdzfbZxr/MaiWzECAwEAAaOCA3kwggN1MB8GA1UdIwQYMBaAFD3TUKXWoK3u80pg
CmXTIdT4+NYPMB0GA1UdDgQWBBSfYnuyiA7uG3ngaSTluj9HpgsC8DAnBgNVHREE
IDAeggt0d2l0dGVyLmNvbYIPd3d3LnR3aXR0ZXIuY29tMA4GA1UdDwEB/wQEAwIF
oDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwdQYDVR0fBG4wbDA0oDKg
MIYuaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItZXYtc2VydmVyLWcxLmNy
bDA0oDKgMIYuaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItZXYtc2VydmVy
LWcxLmNybDBLBgNVHSAERDBCMDcGCWCGSAGG/WwCATAqMCgGCCsGAQUFBwIBFhxo
dHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAcGBWeBDAEBMIGIBggrBgEFBQcB
AQR8MHowJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBSBggr
BgEFBQcwAoZGaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hB
MkV4dGVuZGVkVmFsaWRhdGlvblNlcnZlckNBLmNydDAMBgNVHRMBAf8EAjAAMIIB
fAYKKwYBBAHWeQIEAgSCAWwEggFoAWYAdgCkuQmQtBhYFIe7E6LMZ3AKPDWYBPkb
37jjd80OyA3cEAAAAVNdgFLZAAAEAwBHMEUCICZCA9wZjkyHJRy3UTCYnwI21m/U
XKRXWc7US9arx68qAiEAtK1UZMDl2wRt/o1OxInzFdQCQ+2QTIvLbHe5slXu6boA
dQBo9pj4H2SCvjqM7rkoHUz8cVFdZ5PURNEKZ6y7T0/7xAAAAVNdgFKcAAAEAwBG
MEQCIGF6AFQ8TKA8AqktUZ/45JJuKYHCIFIkqcPWIIDLWIZmAiA5PVUV5BBCM2AK
ce/CeXCyim1y140g/4RxghYW6sNCNwB1AFYUBpov18Ls0/XhvUSyPsdGdrm8mRFc
wO+UmFXWidDdAAABU12AU6YAAAQDAEYwRAIgXUM1kBRW2bTGAqVvy/aDoYTrdKvM
I6x5p0FF2S+jGmkCIFmAWDXHV/YBi4thS8HGZc3iVCh5wwaCGM3kztEaUYmQMA0G
CSqGSIb3DQEBCwUAA4IBAQC7+PUbZaNQAx8YEMg1Uy+cih5Iar3l5ljJ0eih/KsD
Qo9Y8woYppEuwVC3cN0V2q0I8RXSRE105BgrZbYF2fn32CRs21/sbH0/v6VMonNo
OEJBzeL20fjYidN1Sr39q02e7kjJNCPVg8yTlRREpSXlsfwXWFOnACSBwpRzmD43
bRKVH6zjIPiy2wmxXP6ibb3p0ITHnosxLsf3pWXjL/YeWqQq6mUDMRKmeCRR3k1E
03kXQyxV4AD4hccLqP4K6m17dOkpWbKWNN+/wxWy/ApMuP0hNPgoZSLQBaMidNzh
Y63izHj1KcOdLNg8VVCCEPoEX8IlbLMIY/YTfN5XAFjs
-----END CERTIFICATE-----
}
    end
  end

  describe "#x509" do
    it do
      expect(subject.x509).to be_kind_of(OpenSSL::X509::Certificate)
    end
  end

  describe "#extensions" do
    it do
      expect(subject.extensions).to be_a(Array).and(all(be_kind_of(OpenSSL::X509::Extension)))
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
end

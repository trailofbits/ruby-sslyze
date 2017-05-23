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
      expect(subject.sha1_fingerprint).to be == 'ec9cc6bcfe15035b362477f11ce62cae8257224c'
    end
  end

  describe "#hpkp_sha256_pin" do
    it "should parse the 'hpkpSha256Pin' attribute" do
      expect(subject.hpkp_sha256_pin).to be == '5ca/gOVtlrE/0dx8SO6Ppl+ZExxlOi8StwNCkTAlNi0='
    end
  end

  describe "#as_pem" do
    it "should parse the asPEM element" do
      expect(subject.as_pem).to be == %{-----BEGIN CERTIFICATE-----
MIIKDDCCCPSgAwIBAgIQBvUUkz8IiwtuE2EymBXnaTANBgkqhkiG9w0BAQsFADBw
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMS8wLQYDVQQDEyZEaWdpQ2VydCBTSEEyIEhpZ2ggQXNz
dXJhbmNlIFNlcnZlciBDQTAeFw0xNzA1MTkwMDAwMDBaFw0xNzEwMTcxMjAwMDBa
MF4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTESMBAGA1UEBxMJU3Vubnl2YWxl
MRQwEgYDVQQKDAtZYWhvbyEgSW5jLjEYMBYGA1UEAwwPKi53d3cueWFob28uY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5TiXgVkuxW8+Z1VHGJCa
p1FHJn1q3TMUDUlW2fFbKIc1GEGNbx5/tzirSmqZGcAJVRvNZidrwlwhFMmetnIL
Mbe6LwSFDk39m3WhyEpo0GQXxZUDufdYVwgabCVwrgtYyEikO9b5rrAJmTknDQQM
lx2INNaAf93jQVGEdWyKFUxIFRsoNXkxQh62meVfKr+OUufhjvkVETY1tCfra/+J
nufW23v9n/IGVtxfCJJ3Yh6Hbd6ksNms/qrdkwIGyTBqD2hf7NWgjQNBFIYVe+MR
jllYB6RfsQd1ZosP3ISUaFSzh74knyL1ZmmfyrAjwUFunaIdZEtXIo1bzkfsUulN
FQIDAQABo4IGsjCCBq4wHwYDVR0jBBgwFoAUUWj/kK8CB3U8zNllZGKiErhZcjsw
HQYDVR0OBBYEFGXaiW/WogBnG1KvEJK5tjSgu91NMIIC5wYDVR0RBIIC3jCCAtqC
Dyoud3d3LnlhaG9vLmNvbYIQYWRkLm15LnlhaG9vLmNvbYIPKi5hdHQueWFob28u
Y29tgg1hdHQueWFob28uY29tggxhdS55YWhvby5jb22CDGJlLnlhaG9vLmNvbYIN
YnJiLnlhaG9vLmNvbYIMYnIueWFob28uY29tgg9jYS5teS55YWhvby5jb22CE2Nh
LnJvZ2Vycy55YWhvby5jb22CDGNhLnlhaG9vLmNvbYIQZGRsLmZwLnlhaG9vLmNv
bYIMZGUueWFob28uY29tghRlbi1tYWt0b29iLnlhaG9vLmNvbYIRZXNwYW5vbC55
YWhvby5jb22CDGVzLnlhaG9vLmNvbYIPZnItYmUueWFob28uY29tghZmci1jYS5y
b2dlcnMueWFob28uY29tghJmcm9udGllci55YWhvby5jb22CDGZyLnlhaG9vLmNv
bYIMZ3IueWFob28uY29tggxoay55YWhvby5jb22CDmhzcmQueWFob28uY29tghdp
ZGVhbmV0c2V0dGVyLnlhaG9vLmNvbYIMaWQueWFob28uY29tggxpZS55YWhvby5j
b22CDGluLnlhaG9vLmNvbYIMaXQueWFob28uY29tghFtYWt0b29iLnlhaG9vLmNv
bYISbWFsYXlzaWEueWFob28uY29tggxteS55YWhvby5jb22CDG56LnlhaG9vLmNv
bYIMcGgueWFob28uY29tggxxYy55YWhvby5jb22CDHJvLnlhaG9vLmNvbYIMc2Uu
eWFob28uY29tggxzZy55YWhvby5jb22CDHR3LnlhaG9vLmNvbYIMdWsueWFob28u
Y29tggx1cy55YWhvby5jb22CEXZlcml6b24ueWFob28uY29tggx2bi55YWhvby5j
b22CDXd3dy55YWhvby5jb22CCXlhaG9vLmNvbYIMemEueWFob28uY29tgg16ZWQu
eWFob28uY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYI
KwYBBQUHAwIwdQYDVR0fBG4wbDA0oDKgMIYuaHR0cDovL2NybDMuZGlnaWNlcnQu
Y29tL3NoYTItaGEtc2VydmVyLWc1LmNybDA0oDKgMIYuaHR0cDovL2NybDQuZGln
aWNlcnQuY29tL3NoYTItaGEtc2VydmVyLWc1LmNybDBMBgNVHSAERTBDMDcGCWCG
SAGG/WwBATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2VydC5jb20v
Q1BTMAgGBmeBDAECAjCBgwYIKwYBBQUHAQEEdzB1MCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5kaWdpY2VydC5jb20wTQYIKwYBBQUHMAKGQWh0dHA6Ly9jYWNlcnRz
LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJIaWdoQXNzdXJhbmNlU2VydmVyQ0Eu
Y3J0MAwGA1UdEwEB/wQCMAAwggH3BgorBgEEAdZ5AgQCBIIB5wSCAeMB4QB2AKS5
CZC0GFgUh7sTosxncAo8NZgE+RvfuON3zQ7IDdwQAAABXB4N1/wAAAQDAEcwRQIh
ANrT84td+5qM/GZTO+F5pgyaS0xsFoSfMZwyneQ84DpHAiBn505DT60/Xpf0yX1W
/uNrvU8sFeCFMqa/iR9Ew04vwgB1AFYUBpov18Ls0/XhvUSyPsdGdrm8mRFcwO+U
mFXWidDdAAABXB4N2KYAAAQDAEYwRAIgZYMqchHLf1nfI9BH2oeC9zv5nQ6FVOlm
hPLRN909WdQCIDcEQcsppJg3v+W9h1blIeXPZNUSsiKQYt7WXjkbNQfjAHcA7ku9
t3XOYLrhQmkfq+GeZqMPfl+wctiDAMR7iXqo/csAAAFcHg3a9wAABAMASDBGAiEA
4ABNIoDaloDLhmMXn1BDa4bHoBktSfxEPi3QFtZOhyUCIQDPO0yLZ/iguOyheRef
L55eovHcy+RDHpVCcPiKsdVU+wB3ALvZ37wfinG1k5Qjl6qSe0c4V5UKq1LoGpCW
ZDaOHtGFAAABXB4N2MMAAAQDAEgwRgIhAIcijjvUfmImqfxIqgcyakFdYaczN9gV
NC8NvtyKPA2gAiEAg16fxW8qD4ZhvbzkB7OJedWZS3Aktkp/+XJmYmhFfKYwDQYJ
KoZIhvcNAQELBQADggEBAEKolU+G49oqtFkybyPUpYqHc9A8y4EyTGeRneNBca1A
4se2+2ucsqLqvi404iUIiE7Ie2kujZz/tMD/C8rOvV5nheZcOhcylZ7HkICdYK5k
5CzcU7CkKCLcuPJ3gSOVzhNIzyaCICtoKq7wDk9EMf0gNqdvUH6BA50+nZW5V9x6
0FpmkVCKjlYUCID5ssj4Z7mWxH1SfsJxjE/1MOHbtjFJDABE2YDnER9BhA4lrcnI
Lw0aQOkg48E2NiviLNwLpG7Uy+Lxf5X35l2W0T7vYmJ9Ya8OepK1xXF7FQ1BaQjV
gGpjRh+qBeVGKOShDcxkzEkML7TW+vG+SiAZuq9vxH8=
-----END CERTIFICATE-----
}
    end
  end

  describe "#x509" do
    it do
      expect(subject.x509).to be_kind_of(OpenSSL::X509::Certificate)
    end
  end
end

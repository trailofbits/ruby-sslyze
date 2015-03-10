require 'spec_helper'
require 'xml_examples'
require 'sslyze/certificate'

describe SSLyze::Certificate do
  include_examples "XML specs"

  subject { described_class.new(xml.at('/document/results/target/certinfo/certificateChain/certificate')) }

  describe "#position" do
    it "should parse the position attribute" do
      expect(subject.position).to be :leaf
    end
  end

  describe "#sha1_fingerprint" do
    it "should parse the sha1Fingerprint attribute" do
      expect(subject.sha1_fingerprint).to be == 'a0c4a74600eda72dc0becb9a8cb607ca58ee745e'
    end
  end

  describe "#as_pem" do
    it "should parse the asPEM element" do
      expect(subject.as_pem).to be == %{
-----BEGIN CERTIFICATE-----
MIIF4DCCBMigAwIBAgIQDACTENIG2+M3VTWAEY3chzANBgkqhkiG9w0BAQsFADB1
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMTQwMgYDVQQDEytEaWdpQ2VydCBTSEEyIEV4dGVuZGVk
IFZhbGlkYXRpb24gU2VydmVyIENBMB4XDTE0MDQwODAwMDAwMFoXDTE2MDQxMjEy
MDAwMFowgfAxHTAbBgNVBA8MFFByaXZhdGUgT3JnYW5pemF0aW9uMRMwEQYLKwYB
BAGCNzwCAQMTAlVTMRkwFwYLKwYBBAGCNzwCAQITCERlbGF3YXJlMRAwDgYDVQQF
Ewc1MTU3NTUwMRcwFQYDVQQJEw41NDggNHRoIFN0cmVldDEOMAwGA1UEERMFOTQx
MDcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1T
YW4gRnJhbmNpc2NvMRUwEwYDVQQKEwxHaXRIdWIsIEluYy4xEzARBgNVBAMTCmdp
dGh1Yi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCx1Nw8r/3z
Tu3BZ63myyLot+KrKPL33GJwCNEMr9YWaiGwNksXDTZjBK6/6iBRlWVm8r+5TaQM
Kev1FbHoNbNwEJTVG1m0Jg/Wg1dZneF8Cd3gE8pNb0Obzc+HOhWnhd1mg+2TDP4r
bTgceYiQz61YGC1R0cKj8keMbzgJubjvTJMLy4OUh+rgo7XZe5trD0P5yu6ADSin
dvEl9ME1PPZ0rd5qM4J73P1LdqfC7vJqv6kkpl/nLnwO28N0c/p+xtjPYOs2ViG2
wYq4JIJNeCS66R2hiqeHvmYlab++O3JuT+DkhSUIsZGJuNZ0ZXabLE9iH6H6Or6c
JL+fyrDFwGeNAgMBAAGjggHuMIIB6jAfBgNVHSMEGDAWgBQ901Cl1qCt7vNKYApl
0yHU+PjWDzAdBgNVHQ4EFgQUakOQfTuYFHJSlTqqKApD+FF+06YwJQYDVR0RBB4w
HIIKZ2l0aHViLmNvbYIOd3d3LmdpdGh1Yi5jb20wDgYDVR0PAQH/BAQDAgWgMB0G
A1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjB1BgNVHR8EbjBsMDSgMqAwhi5o
dHRwOi8vY3JsMy5kaWdpY2VydC5jb20vc2hhMi1ldi1zZXJ2ZXItZzEuY3JsMDSg
MqAwhi5odHRwOi8vY3JsNC5kaWdpY2VydC5jb20vc2hhMi1ldi1zZXJ2ZXItZzEu
Y3JsMEIGA1UdIAQ7MDkwNwYJYIZIAYb9bAIBMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYgGCCsGAQUFBwEBBHwwejAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMFIGCCsGAQUFBzAChkZodHRw
Oi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyRXh0ZW5kZWRWYWxp
ZGF0aW9uU2VydmVyQ0EuY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQAD
ggEBAG/nbcuC8++QhwnXDxUiLIz+06scipbbXRJd0XjAMbD/RciJ9wiYUhcfTEsg
ZGpt21DXEL5+q/4vgNipSlhBaYFyGQiDm5IQTmIte0ZwQ26jUxMf4pOmI1v3kj43
FHU7uUskQS6lPUgND5nqHkKXxv6V2qtHmssrA9YNQMEK93ga2rWDpK21mUkgLviT
PB5sPdE7IzprOCp+Ynpf3RcFddAkXb6NqJoQRPrStMrv19C1dqUmJRwIQdhkkqev
ff6IQDlhC8BIMKmCNK33cEYDfDWROtW7JNgBvBTwww8jO1gyug8SbGZ6bZ3k8OV8
XX4C2NesiZcLYbc2n7B9O+63M2k=
-----END CERTIFICATE-----
      }.strip
    end
  end

  describe "#subject_public_key_info" do
    it "must return a Certificate::SubjectPublicKeyInfo object" do
      expect(subject.subject_public_key_info).to be_kind_of(described_class::SubjectPublicKeyInfo)
    end
  end

  describe "#version" do
    it "should parse the version element" do
      expect(subject.version).to be == 2
    end
  end

  describe "#extensions" do
    subject { super().extensions }

    it "should return an Extensions object" do
      expect(subject).to be_kind_of(described_class::Extensions)
    end

    describe "#x509v3_subject_key_identifier" do
      subject { super().x509v3_subject_key_identifier }

      it "should parse the X509v3SubjectKeyIdentifier element" do
        expect(subject).to be == '6A:43:90:7D:3B:98:14:72:52:95:3A:AA:28:0A:43:F8:51:7E:D3:A6'
      end
    end

    describe "#x509v3_extended_key_usage" do
      subject { super().x509v3_extended_key_usage }

      it "should return a X509v3ExtendedKeyUsage object" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3ExtendedKeyUsage)
      end

      describe "#tls_web_client_authentication" do
        subject { super().tls_web_client_authentication }

        it "should parse the TLSWebClientAuthentication element" do
          expect(subject).to be == ''
        end
      end

      describe "#tls_web_server_authentication" do
        subject { super().tls_web_server_authentication }

        it "should parse the TLSWebServerAuthentication element" do
          expect(subject).to be == ''
        end
      end
    end

    describe "#authority_information_access" do
      subject { super().authority_information_access }

      it "should return an AuthorityInformationAccess object" do
        expect(subject).to be_kind_of(described_class::Extensions::AuthorityInformationAccess)
      end

      describe "#ca_issuers" do
        subject { super().ca_issuers }

        it "should parse the CAIssuers element" do
          expect(subject).to be == [
            URI('http://cacerts.digicert.com/DigiCertSHA2ExtendedValidationServerCA.crt')
          ]
        end
      end

      describe "#ocsp" do
        subject { super().ocsp }

        it "should parse the OCSP element" do
          expect(subject).to be == [
            URI('http://ocsp.digicert.com')
          ]
        end
      end
    end

    describe "#x509v3_crl_distribution_points" do
      subject { super().x509v3_crl_distribution_points }

      it "should return a X509v3CRLDistributionPoints object" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3CRLDistributionPoints)
      end

      describe "#full_name" do
        subject { super().full_name }

        it "should parse the FullName element" do
          expect(subject).to be == ['', '']
        end
      end

      describe "#uri" do
        subject { super().uri }

        it "should parse the URI element" do
          expect(subject).to be == [
            URI('http://crl3.digicert.com/sha2-ev-server-g1.crl'),
            URI('http://crl4.digicert.com/sha2-ev-server-g1.crl')
          ]
        end
      end
    end

    describe "#x509v3_basic_constraints" do
      subject { super().x509v3_basic_constraints }

      it "should parse the X509v3BasicConstraints element" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3BasicConstraints)
      end

      describe "#ca?" do
        subject { super().ca? }

        it "should parse the 'CA:' constraint" do
          expect(subject).to be false
        end
      end

      describe "#path_length" do
        subject { super().path_length }

        pending "need data" do
          it "should parse the 'pathLen:' constraint" do
            expect(subject).to be == 0
          end
        end
      end
    end

    describe "#x509v3_key_usage" do
      subject { super().x509v3_key_usage }

      it "should return a X509v3KeyUsage object" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3KeyUsage)
      end

      describe "#key_encipherment" do
        subject { super().key_encipherment }

        it "should parse the KeyEncipherment element" do
          expect(subject).to be == ''
        end
      end

      describe "#digital_signature" do
        subject { super().digital_signature }

        it "should parse the DigitalSignature element" do
          expect(subject).to be == ''
        end
      end
    end

    describe "#x509v3_subject_alternative_name" do
      subject { super().x509v3_subject_alternative_name }

      it "should parse the X509v3SubjectAlternativeName elements" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3SubjectAlternativeName)
      end

      describe "#dns" do
        subject { super().dns }

        it "should parse the DNS/listEntry elements" do
          expect(subject).to be == [
            'github.com',
            'www.github.com'
          ]
        end
      end
    end

    describe "#x509v3_authority_key_identifier" do
      subject { super().x509v3_authority_key_identifier }

      it "should parse the X509v3AuthorityKeyIdentifier element" do
        expect(subject).to be == 'keyid:3D:D3:50:A5:D6:A0:AD:EE:F3:4A:60:0A:65:D3:21:D4:F8:F8:D6:0F'
      end
    end

    describe "#x509v3_certificate_policies" do
      subject { super().x509v3_certificate_policies }

      it "should return a X509v3CertificatePolicies object" do
        expect(subject).to be_kind_of(described_class::Extensions::X509v3CertificatePolicies)
      end

      describe "#policy" do
        subject { super().policy }

        it "should parse the Policy element" do
          expect(subject).to be == ['2.16.840.1.114412.2.1']
        end
      end

      describe "#explicit_text" do
        subject { super().explicit_text }

        it "should parse the ExplicitText element" do
          expect(subject).to be == []
        end
      end

      describe "#cps" do
        subject { super().cps }

        it "should parse the CPS element" do
          expect(subject).to be == ['https://www.digicert.com/CPS']
        end
      end

      describe "#user_notice" do
        subject { super().user_notice }

        it "should parse the UserNotice element" do
          expect(subject).to be == []
        end
      end
    end
  end

  describe "#signature_value" do
    it "should parse the signatureValue element" do
      expect(subject.signature_value).to be == %{6f:e7:6d:cb:82:f3:ef:90:87:09:d7:0f:15:22:2c:8c:fe:d3:ab:1c:8a:96:db:5d:12:5d:d1:78:c0:31:b0:ff:45:c8:89:f7:08:98:52:17:1f:4c:4b:20:64:6a:6d:db:50:d7:10:be:7e:ab:fe:2f:80:d8:a9:4a:58:41:69:81:72:19:08:83:9b:92:10:4e:62:2d:7b:46:70:43:6e:a3:53:13:1f:e2:93:a6:23:5b:f7:92:3e:37:14:75:3b:b9:4b:24:41:2e:a5:3d:48:0d:0f:99:ea:1e:42:97:c6:fe:95:da:ab:47:9a:cb:2b:03:d6:0d:40:c1:0a:f7:78:1a:da:b5:83:a4:ad:b5:99:49:20:2e:f8:93:3c:1e:6c:3d:d1:3b:23:3a:6b:38:2a:7e:62:7a:5f:dd:17:05:75:d0:24:5d:be:8d:a8:9a:10:44:fa:d2:b4:ca:ef:d7:d0:b5:76:a5:26:25:1c:08:41:d8:64:92:a7:af:7d:fe:88:40:39:61:0b:c0:48:30:a9:82:34:ad:f7:70:46:03:7c:35:91:3a:d5:bb:24:d8:01:bc:14:f0:c3:0f:23:3b:58:32:ba:0f:12:6c:66:7a:6d:9d:e4:f0:e5:7c:5d:7e:02:d8:d7:ac:89:97:0b:61:b7:36:9f:b0:7d:3b:ee:b7:33:69}
    end
  end

  describe "#signature_algorithm" do
    it "should parse the signatureAlgorithm element" do
      expect(subject.signature_algorithm).to be == 'sha256WithRSAEncryption'
    end
  end

  describe "#serial_number" do
    it "should parse the serialNumber element" do
      expect(subject.serial_number).to be == '0C009310D206DBE337553580118DDC87'
    end
  end

  describe "#subject" do
    it "should return a Subject object" do
      expect(subject.subject).to be_kind_of(described_class::Subject)
    end
  end

  describe "#validity" do
    it "should return a Validity object" do
      expect(subject.validity).to be_kind_of(described_class::Validity)
    end

    it "should parse the validity/notAfter element" do
      expect(subject.validity.not_after).to be == Date.parse('Apr 12 12:00:00 2016 GMT')
    end

    it "should parse the validity/notBefore element" do
      expect(subject.validity.not_before).to be == Date.parse('Apr  8 00:00:00 2014 GMT')
    end
  end

  describe "#issuer" do
    it "should return an Issuer object" do
      expect(subject.issuer).to be_kind_of(described_class::Issuer)
    end
  end
end

### 1.2.1 / 2020-05-05

* Allow {SSLyze::XML#total_scan_time} to return `nil`, if the `totalScanTime`
  attribute is missing.

### 1.2.0 / 2018-04-03

* Replaced `SSLyze::X509::PublicKey` with
  {SSLyze::XML::Certinfo::Certificate::PublicKey}.

### 1.1.0 / 2018-03-12

* Require [sslyze] >= 1.4.0
* Added {SSLyze::XML::InvalidTarget#target}.
* Added {SSLyze::XML::InvalidTarget#port}.
* Added the `--update_trust_stores` option.
* Added the `--robot` option.
* Replaced the `--timeout` and `--nb_retries` options with `--slow_connection`.

### 1.0.0 / 2018-03-06

* Require [sslyze] >= 1.3.4.
* Added {SSLyze::X509::Domain}.
* Added {SSLyze::X509::Extension}.
* Added {SSLyze::X509::ExtensionSet}.
* Added {SSLyze::X509::Extensions::BasicConstraints}.
* Added {SSLyze::X509::Extensions::CertificatePolicies}.
* Added {SSLyze::X509::Extensions::CRLDistributionPoints}.
* Added {SSLyze::X509::Extensions::ExtendedKeyUsage}.
* Added {SSLyze::X509::Extensions::KeyUsage}.
* Added {SSLyze::X509::Extensions::SubjectAltName}.
* Added {SSLyze::X509::Name}.
* Added `SSLyze::X509::PublicKey`.
* Moved all XML related classes into {SSLyze::XML}.
* Updated {SSLyze::XML} and classes to represent the current sslyze 1.3.4 XSD.

### 0.2.1 / 2017-01-13

* Fix file descriptor leak in {SSLyze::XML.open} by using
  `File.open(path) { |file| ... }` instead of `File.new(path)`, which keeps the
  file descriptor open until GC collects the `File` instance.

### 0.2.0 / 2016-08-16

* Requires sslyze 0.12.x.
* Added `SSLyze::XML#each_invalid_target`.
* Added `SSLyze::XML#invalid_targets`.
* Added `SSLyze::InvalidTarget`.
* Added `SSLyze::Target#ssl_v2` alias.
* Added `SSLyze::Target#ssl_v3` alias.
* Added `SSLyze::Target#tls_v1` alias.
* Added `SSLyze::Target#tls_v1_1` alias.
* Added `SSLyze::Target#tls_v1_2` alias.
* Added `SSLyze::CertificateValidation#path?`.
* Added `SSLyze::CertificateValidation#results`.
* Fixed a bug in `SSLyze::CertInfo#validation` when the `certificateValidation`
  node is omitted.

### 0.1.1 / 2015-12-08

* `certificateValidation` may be omitted from `certinfo` if an OpenSSL
  exception occurred. Allow `SSLyze::CertInfo#validation` may return `nil`.

### 0.1.0 / 2015-10-13

* Initial release:
  * Provides a Ruby interface to `sslyze.py`.
  * Provides a Parser for consuming the sslyze XML output.
  * [sslyze] >= 0.12

[sslyze]: https://github.com/nabla-c0d3/sslyze#readme

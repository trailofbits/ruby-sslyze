### 0.2.0 / 2015-12-08

* Added {SSLyze::XML#each_invalid_target}.
* Added {SSLyze::XML#invalid_targets}.
* Added {SSLyze::CertificateValidation#path?}.

### 0.1.1 / 2015-12-08

* `certificateValidation` may be omitted from `certinfo` if an OpenSSL
  exception occurred. Allow {SSLyze::CertInfo#validation} may return `nil`.

### 0.1.0 / 2015-10-13

* Initial release:
  * Provides a Ruby interface to `sslyze.py`.
  * Provides a Parser for consuming the sslyze XML output.
  * [sslyze] >= 0.12

[sslyze]: https://github.com/nabla-c0d3/sslyze#readme

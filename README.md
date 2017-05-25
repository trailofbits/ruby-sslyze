# ruby-sslyze

[![Code Climate](https://codeclimate.com/github/trailofbits/ruby-sslyze/badges/gpa.svg)](https://codeclimate.com/github/trailofbits/ruby-sslyze)
[![Test Coverage](https://codeclimate.com/github/trailofbits/ruby-sslyze/badges/coverage.svg)](https://codeclimate.com/github/trailofbits/ruby-sslyze)
[![Build Status](https://travis-ci.org/trailofbits/ruby-sslyze.svg)](https://travis-ci.org/trailofbits/ruby-sslyze)

* [Homepage](https://github.com/trailofbits/ruby-sslyze#readme)
* [Issues](https://github.com/trailofbits/ruby-sslyze/issues)
* [Documentation](http://rubydoc.info/gems/ruby-sslyze/frames)

## Description

A Ruby interface to [sslyze] python utility.

## Features

* Provides a Ruby interface to `sslyze.py`.
* Provides a Parser for consuming the sslyze XML output.
* Supports [sslyze] 1.x.

## Examples

Analyze a domain:

    require 'sslyze'

    SSLyze::Program.analyze(targets: 'twitter.com', regular: true, timeout: 5)

Analyze multiple domains:

    SSLyze::Program.analyze(
      targets: ['twitter.com', 'github.com'],
      regular: true,
      timeout: 5
    )

Output to XML:

    SSLyze::Program.analyze(
      targets: 'twitter.com',
      regular: true,
      timeout: 5,
      xml_out: 'path/to/xml'
    )

Parsing sslyze XML output:

    xml = SSLyze::XML.open('path/to/xml')

## Requirements

* [rprogram] ~> 0.3
* [nokogiri] ~> 1.0
* [sslyze] 1.x

## Install

    $ pip install sslyze
    $ gem install ruby-sslyze

## Copyright

Copyright (c) 2014-2017 Hal Brodigan

See {file:LICENSE.txt} for details.

[sslyze]: https://github.com/nabla-c0d3/sslyze#readme

[rpgoram]: https://github.com/postmodern/rprogram#readme
[nokogiri]: http://www.nokogiri.org/

# -*- encoding: utf-8 -*-

require File.expand_path('../lib/sslyze/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "ruby-sslyze"
  gem.version       = SSLyze::VERSION
  gem.summary       = %q{Ruby interface to sslyze}
  gem.description   = %q{A ruby interface to the sslyze python utility}
  gem.license       = "MIT"
  gem.authors       = ["Hal Brodigan"]
  gem.email         = "postmodern.mod3@gmail.com"
  gem.homepage      = "https://github.com/trailofbits/ruby-sslyze#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.requirements << 'sslyze >= 1.4.0'

  gem.add_dependency 'rprogram', '~> 0.3'
  gem.add_dependency 'nokogiri', '~> 1.8'

  gem.add_development_dependency 'bundler', '~> 2.0'
end

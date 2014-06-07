# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apihub/version'

Gem::Specification.new do |spec|
  spec.name          = "apihub"
  spec.version       = APIHub::VERSION
  spec.authors       = ["Alex MacCaw"]
  spec.email         = ["alex@apihub.co"]
  spec.description   = %q{API client for apihub.co}
  spec.summary       = %q{API client for apihub.co}
  spec.homepage      = "https://github.com/maccman/apihub-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_dependency 'nestful', '~> 1.0.7'
end

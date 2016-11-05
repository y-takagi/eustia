# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eustia/version'

Gem::Specification.new do |spec|
  spec.name          = "eustia"
  spec.version       = Eustia::VERSION
  spec.authors       = ["y-takagi"]
  spec.email         = ["ytakagi.deb@gmail.com"]

  spec.summary       = %q{Digdag client wrapper built with Sinatra.}
  spec.description   = %q{Digdag client wrapper built with Sinatra.}
  spec.homepage      = "https://github.com/y-takagi/eustia"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
end

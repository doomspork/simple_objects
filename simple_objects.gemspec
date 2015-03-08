# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_objects/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_objects'
  spec.version       = SimpleObjects::VERSION
  spec.authors       = ['Sean Callan']
  spec.email         = ['seancallan@gmail.com']
  spec.summary       = 'Simple objects for Ruby' 
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',    '~> 1.7'
  spec.add_development_dependency 'coveralls',  '~> 0.7'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'rspec',      '~> 3.1'
  spec.add_development_dependency 'rspec-its',  '~> 1.0'
  spec.add_development_dependency 'simplecov',  '~> 0.9'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_markdown_extension/version'

Gem::Specification.new do |spec|
  spec.name          = 'mongoid_markdown_extension'
  spec.version       = MongoidMarkdownExtension::VERSION
  spec.authors       = ['Tomas Celizna']
  spec.email         = ['mail@tomascelizna.com']
  spec.description   = 'Custom field type for Mongoid that handles Markdown conversion via Redcarpet gem.'
  spec.summary       = 'Custom field type for Mongoid that handles Markdown conversion via Redcarpet gem.'
  spec.homepage      = 'https://github.com/tomasc/mongoid_markdown_extension'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'redcarpet', '~> 3.4'
  spec.add_dependency 'mongoid', '>= 4.0', '< 8'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake', '~> 10.0'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_markdown_extension/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_markdown_extension"
  spec.version       = MongoidMarkdownExtension::VERSION
  spec.authors       = ["Tomas Celizna"]
  spec.email         = ["tomas.celizna@gmail.com"]
  spec.description   = %q{Handles markdown conversion}
  spec.summary       = %q{Handles markdown conversion}
  spec.homepage      = "https://github.com/tomasc/mongoid_markdown_extension"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redcarpet", ">= 3.1.2"
  spec.add_dependency "mongoid", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

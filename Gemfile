source 'https://rubygems.org'

# Specify your gem's dependencies in mongoid_markdown_extension.gemspec
gemspec

case version = ENV['MONGOID_VERSION'] || '~> 7.0'
when /7/ then gem 'mongoid', '~> 7.0'
when /6/ then gem 'mongoid', '~> 6.0'
when /5/ then gem 'mongoid', '~> 5.1'
when /4/ then gem 'mongoid', '~> 4.0'
else gem 'mongoid', version
end

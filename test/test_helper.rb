require 'bundler/setup'
require 'mongoid'
require 'mongoid_markdown_extension'
require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

require 'mongoid_markdown_extension'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

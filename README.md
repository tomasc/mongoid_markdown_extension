# Mongoid Markdown Extension

[![Build Status](https://travis-ci.org/tomasc/mongoid_markdown_extension.svg)](https://travis-ci.org/tomasc/mongoid_markdown_extension) [![Gem Version](https://badge.fury.io/rb/mongoid_markdown_extension.svg)](http://badge.fury.io/rb/mongoid_markdown_extension) [![Coverage Status](https://img.shields.io/coveralls/tomasc/mongoid_markdown_extension.svg)](https://coveralls.io/r/tomasc/mongoid_markdown_extension)

[Mongoid](https://github.com/mongoid/mongoid) field extension that returns an object with `to_html` method returning the content converted from Markdown syntax to html. The Markdown conversion is done using the [Redcarpet](https://github.com/vmg/redcarpet) library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_markdown_extension'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install mongoid_markdown_extension
```

## Configuration

The defaults are as follows:

```ruby
extensions = {
  autolink: true
  footnotes: true
  highlight: true
  space_after_headers: true
  strikethrough: true
  superscript: true
}

render_options = {}
```

These can be overwritten with an initializer, for example `config/initializers/mongoid_markdown.rb`:

```ruby
MongoidMarkdownExtension::Markdown.configure do |c|
  c.extensions = { autolink: true }
  c.render_class = CustomRenderer
  c.render_options = { filter_html: true }
end
```

See [Redcarpet documentation](https://github.com/vmg/redcarpet) for available extensions and render options.

## Usage

Add to a Mongoid model:

```ruby
class MyModel
  include Mongoid::Document
  field :text, type: MongoidMarkdownExtension::Markdown
end
```

Use it:

```Ruby
my_model.text = "*foo*"

my_model.text.to_html # => <strong>foo</strong>
my_model.text.to_s # => *foo*
```

## Contributing

1. Fork it ( https://github.com/tomasc/mongoid_markdown_extension/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Mongoid Markdown Extension

Returns a Markdown object with to_html (using Redcarpet) method.

Default options:

* autolink: true
* footnotes: true
* highlight: true
* space_after_headers: true
* strikethrough: true
* superscript: true

These can be overwritten with an initializer.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_markdown_extension'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_markdown_extension

## Configuration

    TODO

## Usage

Add to Mongoid models as:

    field :text, type: MongoidMarkdownExtension::Markdown

## Contributing

1. Fork it ( https://github.com/tomasc/mongoid_markdown_extension/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

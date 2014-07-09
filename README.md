# Mongoid Markdown Extension

[Mongoid](https://github.com/mongoid/mongoid) field extension that returns an object with `to_html` method returning the content converted from Markdown syntax to html. The Markdown conversion is done using the [Redcarpet](https://github.com/vmg/redcarpet) library.

Default options:

* autolink: true
* footnotes: true
* highlight: true
* space_after_headers: true
* strikethrough: true
* superscript: true

These can be overwritten with an initializer. See Configuration below.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_markdown_extension'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_markdown_extension

## Configuration

TODO: describe configuration options

## Usage

Add to Mongoid models:

    class MyModel
        include Mongoid::Document
        field :text, type: MongoidMarkdownExtension::Markdown
    end
    
Use in your views:

    = my_model.text.to_html

## Contributing

1. Fork it ( https://github.com/tomasc/mongoid_markdown_extension/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

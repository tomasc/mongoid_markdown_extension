# Mongoid Markdown Extension

[Mongoid](https://github.com/mongoid/mongoid) field extension that returns an object with `to_html` method returning the content converted from Markdown syntax to html. The Markdown conversion is done using the [Redcarpet](https://github.com/vmg/redcarpet) library.

These can be overwritten with an initializer. See Configuration below.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_markdown_extension'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_markdown_extension

## Configuration

The defaults are as follows:

```Ruby
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

In an initializer `config/initializers/mongoid_markdown.rb`:

```Ruby
MongoidMarkdownExtension::Markdown.configure do |c|
    c.extensions = { autolink: true }
    c.render_options = { filter_html: true }
end
```

See [Redcarpet documentation](https://github.com/vmg/redcarpet) for available extensions and render options.

## Usage

Add to a Mongoid model:

    class MyModel
        include Mongoid::Document
        field :text, type: MongoidMarkdownExtension::Markdown
    end
    
Use it in a view:

    = my_model.text.to_html

## Contributing

1. Fork it ( https://github.com/tomasc/mongoid_markdown_extension/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

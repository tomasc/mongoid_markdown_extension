require 'redcarpet'
require 'redcarpet/render_strip'

module MongoidMarkdownExtension
  class Markdown < String
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def self.demongoize(value)
      Markdown.new(value)
    end

    def self.mongoize(value)
      case value
      when Markdown then value.mongoize
      else value
      end
    end

    def self.evolve(value)
      case value
      when Markdown then value.mongoize
      else value
      end
    end

    def initialize(str)
      super(str.to_s)
    end

    def to_html
      markdown_renderer.render(to_s).html_safe
    end

    def to_inline_html(line_breaks: false)
      rendered = markdown_inline_renderer.render(@str).gsub(/(<br\s?\/?>)+?\z/, '')
      rendered.gsub!(/(<br\s?\/?>)+?\Z/, '') if !line_breaks
      rendered.html_safe
    end

    def to_stripped_s
      markdown_stripdown_renderer.render(to_s).try(:strip)
    end

    private

    def markdown_renderer
      render_class = MongoidMarkdownExtension::Markdown.configuration.render_class
      render_options = MongoidMarkdownExtension::Markdown.configuration.render_options
      extensions = MongoidMarkdownExtension::Markdown.configuration.extensions

      Redcarpet::Markdown.new(render_class.new(render_options), extensions)
    end

    # TODO: how to combine custom render class with the InlineRenderer?
    def markdown_inline_renderer
      render_options = MongoidMarkdownExtension::Markdown.configuration.render_options
      extensions = MongoidMarkdownExtension::Markdown.configuration.extensions
      extensions[:tables] = false

      Redcarpet::Markdown.new(InlineRenderer.new(render_options), extensions)
    end

    def markdown_stripdown_renderer
      Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    end
  end

  class Configuration
    attr_accessor :extensions
    attr_accessor :render_class
    attr_accessor :render_options

    def initialize
      @extensions = {
        autolink: true,
        footnotes: true,
        highlight: true,
        space_after_headers: true,
        strikethrough: true,
        superscript: true
      }
      @render_class = Redcarpet::Render::HTML
      @render_options = {}
    end
  end
end

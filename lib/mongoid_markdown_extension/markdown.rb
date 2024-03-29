require 'redcarpet'
require 'redcarpet/render_strip'

module MongoidMarkdownExtension
  class Markdown < String
    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def reset
        @configuration = Configuration.new
      end

      def configure
        yield(configuration)
      end

      def demongoize(value)
        Markdown.new(value)
      end

      def mongoize(value)
        case value
        when Markdown then value.mongoize
        else value
        end
      end

      def evolve(value)
        case value
        when Markdown then value.mongoize
        else value
        end
      end
    end

    def initialize(str)
      super(str.to_s)
    end

    def split(*args)
      super(*args).map { |str| self.class.new(str) }
    end

    def gsub(*args)
      self.class.new(super(*args))
    end

    def to_html
      markdown_renderer.render(to_s).html_safe
    end

    def to_inline_html(line_breaks: false)
      rendered = markdown_inline_renderer.render(to_s).gsub(/(<br\s?\/?>)+?\z/, '')
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
      inline_render_class = MongoidMarkdownExtension::Markdown.configuration.inline_render_class
      render_options = MongoidMarkdownExtension::Markdown.configuration.render_options
      extensions = MongoidMarkdownExtension::Markdown.configuration.extensions
      extensions[:tables] = false

      Redcarpet::Markdown.new(inline_render_class.new(render_options), extensions)
    end

    def markdown_stripdown_renderer
      Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    end
  end

  class Configuration
    attr_accessor :extensions
    attr_accessor :inline_render_class
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
      @inline_render_class = MongoidMarkdownExtension::InlineRenderer
      @render_class = Redcarpet::Render::HTML
      @render_options = {}
    end
  end
end

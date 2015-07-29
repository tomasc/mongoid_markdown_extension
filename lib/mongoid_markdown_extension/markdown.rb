require 'redcarpet'

module MongoidMarkdownExtension
  class Markdown < String

    def initialize str
      super str.to_s
      @str = str.to_s
    end

    def to_s
      @str
    end

    def to_html
      markdown_renderer.render(@str).html_safe
    end

    def to_inline_html
      markdown_inline_renderer.render(@str).html_safe
    end

    def mongoize
      @str
    end

    private # =============================================================

    def markdown_renderer
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(self.class.configuration.render_options),
        self.class.configuration.extensions
      )
    end

    def markdown_inline_renderer
      Redcarpet::Markdown.new(InlineRenderer, tables: false)
    end

    # ---------------------------------------------------------------------

    class << self

      attr_accessor :configuration

      def configure
        @configuration ||= Configuration.new
        yield @configuration
      end

      def configuration
        @configuration ||= Configuration.new
      end

      def demongoize value
        Markdown.new(value)
      end

      def mongoize value
        case value
        when Markdown then value.mongoize
        else value
        end
      end

      def evolve value
        case value
        when Markdown then value.mongoize
        else value
        end
      end

    end
  end

  # ---------------------------------------------------------------------

  class Configuration
    attr_accessor :extensions
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
      @render_options = {}
    end
  end

  # ---------------------------------------------------------------------
end

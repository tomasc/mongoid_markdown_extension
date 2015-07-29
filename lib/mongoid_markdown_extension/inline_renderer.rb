require 'redcarpet'

module MongoidMarkdownExtension
  class InlineRenderer < Redcarpet::Render::HTML

    include Redcarpet::Render::SmartyPants

    def block_code code, language
      nil
    end

    def block_quote quote
      nil
    end

    def block_html raw_html
      nil
    end

    def footnotes content
      nil
    end

    def footnote_def content, number
      nil
    end

    def header text, header_level
      nil
    end

    def hrule
      nil
    end

    def list contents, list_type
      nil
    end

    def list_item text, list_type
      nil
    end

    def paragraph text
      text
    end

  end
end

require 'redcarpet'

module MongoidMarkdownExtension
  class InlineRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(_code, _language)
      nil
    end

    def block_quote(_quote)
      nil
    end

    def block_html(_raw_html)
      nil
    end

    def footnotes(_content)
      nil
    end

    def footnote_def(_content, _number)
      nil
    end

    def header(_text, _header_level)
      nil
    end

    def hrule
      nil
    end

    def list(_contents, _list_type)
      nil
    end

    def list_item(_text, _list_type)
      nil
    end

    def postprocess(full_document)
      full_document
        .gsub(/(<\/p>\s*<p>)+?/, '<br><br>')
        .gsub(/(<\/?p>)+?/, '')
        .chop
    end
  end
end

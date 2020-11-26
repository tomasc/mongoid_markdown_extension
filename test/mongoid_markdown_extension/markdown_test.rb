require 'test_helper'

class MongoidMarkdownExtensionTest
  include Mongoid::Document
  field :body, type: MongoidMarkdownExtension::Markdown
end

class CustomRenderer < Redcarpet::Render::HTML
  def preprocess(doc)
    doc.gsub(/\[button:(.*)\]\((.*)\)/) do
      button_label = Regexp.last_match(1)
      button_link = Regexp.last_match(2)

      if button_label && button_link
        "<a href='#{button_link}' class='button'>#{button_label}</a>"
      else
        button_label
      end
    end
  end
end

# ---------------------------------------------------------------------

module MongoidMarkdownExtension
  describe Markdown do
    let(:string) { 'some text with _italic_' }
    subject { MongoidMarkdownExtension::Markdown.new(string) }

    after(:each) do
      MongoidMarkdownExtension::Markdown.reset
    end

    describe 'configuration' do
      describe 'setup block' do
        it 'yields self' do
          MongoidMarkdownExtension::Markdown.configure do |config|
            config.must_be_kind_of MongoidMarkdownExtension::Configuration
          end
        end

        it 'returns default values' do
          MongoidMarkdownExtension::Markdown.configuration.extensions.must_equal(
            autolink: true,
            footnotes: true,
            highlight: true,
            space_after_headers: true,
            strikethrough: true,
            superscript: true
          )
          MongoidMarkdownExtension::Markdown.configuration.render_class.must_equal Redcarpet::Render::HTML
          MongoidMarkdownExtension::Markdown.configuration.render_options.must_equal({})
          _(MongoidMarkdownExtension::Markdown.configuration.inline_render_class).must_equal MongoidMarkdownExtension::InlineRenderer
        end
      end
    end

    describe '#to_s' do
      it 'returns the original value' do
        subject.to_s.must_equal string
      end
    end

    describe '#to_html' do
      it 'survives nil' do
        MongoidMarkdownExtension::Markdown.new(nil).to_html.must_equal ''
      end

      it 'converts the string to html' do
        subject.to_html.must_equal Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(string)
      end
    end

    describe '#to_inline_html' do
      let(:string) { "some text with _italic_\n\nfoo" }

      it 'survives nil' do
        MongoidMarkdownExtension::Markdown.new(nil).to_inline_html.must_equal ''
      end

      it 'converts the string to html' do
        subject.to_inline_html.wont_include '<p>'
      end

      it 'replaces <p> with <br />' do
        subject.to_inline_html.must_equal 'some text with <em>italic</em><br /><br />foo'
      end
    end

    describe '#to_stripped_s' do
      it 'survives nil' do
        MongoidMarkdownExtension::Markdown.new(nil).to_stripped_s.must_equal ''
      end

      it 'converts the markdown to stripped string' do
        subject.to_stripped_s.wont_include '_'
      end

      it 'removes newlines' do
        subject.to_stripped_s.wont_include "\n"
      end
    end

    describe '#mongoize' do
      it 'returns string' do
        subject.mongoize.must_equal string
      end
    end

    describe '.mongoize' do
      describe 'when passed a string' do
        it 'returns it back' do
          MongoidMarkdownExtension::Markdown.mongoize(string).must_equal string
        end
      end

      describe 'when passed markdown object' do
        it 'returns its string' do
          MongoidMarkdownExtension::Markdown.mongoize(subject).must_be_kind_of String
        end
      end
    end

    describe '.demongoize' do
      it 'does not change the value' do
        MongoidMarkdownExtension::Markdown.demongoize(string).must_equal string
      end

      it 'returns markdown object' do
        MongoidMarkdownExtension::Markdown.demongoize(string).must_be_kind_of MongoidMarkdownExtension::Markdown
      end
    end
  end
end

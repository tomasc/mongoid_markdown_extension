require 'test_helper'

# ---------------------------------------------------------------------

class MongoidMarkdownExtensionTest
  include Mongoid::Document
  field :body, type: MongoidMarkdownExtension::Markdown
end

# ---------------------------------------------------------------------

module MongoidMarkdownExtension
  describe Markdown do

    let(:string) { 'some text with _italic_' }
    subject { MongoidMarkdownExtension::Markdown.new(string) }

    describe 'configuration' do
      describe 'setup block' do
        it 'yields self' do
          MongoidMarkdownExtension::Markdown.configure do |config|
            config.must_be_kind_of Configuration
          end
        end
        it 'returns default value' do
          MongoidMarkdownExtension::Markdown.configuration.auto_link.must_equal true
        end
      end
    end

    # ---------------------------------------------------------------------

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

    describe '#mongoize' do
      it 'returns string' do
        subject.mongoize.must_equal string
      end
    end

    # ---------------------------------------------------------------------

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
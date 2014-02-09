require 'spec_helper'

describe ApplicationHelper do
  describe '#locale_link_to' do
    context 'root path' do
      before do
        @locale = Locale.new(Locale::DEFAULT)
      end

      it 'works with 0 arguments' do
        expect(helper.locale_link_to("foo", suffix: :root)).
          to eq link_to("foo", root_path('foo'))
      end

      it 'works with one argument' do
        expect(helper.locale_link_to("foo", suffix: :parent_page,
                                            identifiers: ['foo'])).
          to eq link_to("foo", parent_page_path('foo'))
      end

      it 'works with 2 arguments' do
        expect(helper.locale_link_to("foo", suffix: :parent_page,
                                            identifiers: ['foo'])).
          to eq link_to("foo", parent_page_path('foo'))
      end
    end

    context 'locale path' do
      before do
        @locale = Locale.new(Locale::PL)
      end

      it 'works without link text' do
        expect(helper.locale_link_to(suffix: :root)).
          to eq link_to(nil, locale_root_path('pl'))
      end

      it 'works with 0 arguments' do
        expect(helper.locale_link_to("foo", suffix: :root)).
          to eq link_to("foo", locale_root_path('pl'))
      end

      it 'returns root link' do
        expect(helper.locale_link_to("foo-bar", suffix: :child_page,
                                                identifiers: ['foo', 'bar'])).
          to eq link_to("foo-bar", locale_child_page_path('pl', 'foo', 'bar'))
      end

      it 'returns root link' do
        expect(helper.locale_link_to("foo-bar", suffix: :child_page,
                                                identifiers: ['foo', 'bar'])).
          to eq link_to("foo-bar", locale_child_page_path('pl', 'foo', 'bar'))
      end
    end
  end
end

require 'spec_helper'

describe ApplicationHelper do
  describe '#locale_link_to' do
    context 'root path' do
      before do
        @locale = Locale.new(Locale::DEFAULT)
      end

      it 'works with 0 arguments' do
        expect(helper.locale_link_to('foo', :root_path)).
          to eq link_to("foo", root_path('foo'))
      end

      it 'works with one argument' do
        expect(helper.locale_link_to('foo', :parent_page_path,
                                            identifiers: ['foo'])).
          to eq link_to("foo", parent_page_path('foo'))
      end

      it 'works with 2 arguments' do
        expect(helper.locale_link_to('foo', :parent_page_path,
                                            identifiers: ['foo'])).
          to eq link_to('foo', parent_page_path('foo'))
      end
    end

    context 'locale path' do
      before do
        @locale = Locale.new(Locale::PL)
      end

      it 'works without link text' do
        expect(helper.locale_link_to(:root_path)).
          to eq link_to(nil, locale_root_path('pl'))
      end

      it 'works with 0 arguments' do
        expect(helper.locale_link_to('foo', :root_path)).
          to eq link_to('foo', locale_root_path('pl'))
      end

      it 'returns root link' do
        expect(helper.locale_link_to('foo-bar', :child_page_path,
                                                identifiers: ['foo', 'bar'])).
          to eq link_to('foo-bar', locale_child_page_path('pl', 'foo', 'bar'))
      end

      it 'returns root link' do
        expect(helper.locale_link_to('foo-bar', :child_page_path,
                                                identifiers: ['foo', 'bar'])).
          to eq link_to('foo-bar', locale_child_page_path('pl', 'foo', 'bar'))
      end
    end

    context 'with block' do
      before do
        @locale = Locale.new(Locale::DEFAULT)
        allow(self).to receive(:current_page?).and_return true
      end

      it 'handles block' do
        result = locale_link_to('text', :root_path, id: 'brand') do |text|
          "#{text} from block"
        end

        expect(result).to eq "text from block"
      end
    end
  end

  describe '#polymorphic_page_path' do
    it 'returns child page path' do
      page = create :child_page

      expect(path(page)).to eq child_page_path(page.parent_page.permalink,
                                               page.permalink)
    end

    it 'returns locale child page path' do
      page = create :child_page, locale: Locale::EN
      expect(path(page)).to eq locale_child_page_path(Locale::EN,
                                                      page.parent_page.permalink,
                                                      page.permalink)
    end

    it 'returns locale root' do
      page = create :main_page, locale: Locale::EN
      expect(path(page)).to eq locale_root_path(Locale::EN)
    end

    def path(page)
      polymorphic_page_path(page)
    end
  end

  describe '#human_attribute' do
    let(:page) { build :page }
    it 'works for instance' do
      expect(human_attribute(page, :title)).
        to eq I18n.t('activerecord.attributes.page.title')
    end

    it 'works for class' do
      expect(human_attribute(Page, :title)).
        to eq I18n.t('activerecord.attributes.page.title')
    end
  end

  describe '#human_attributes' do
    let(:page) { build :page }

    it 'works for instance' do
      expect(human_attributes(page, :title, :permalink)).
        to eq [
          I18n.t('activerecord.attributes.page.title'),
          I18n.t('activerecord.attributes.page.permalink')
        ]
    end

    it 'works for class' do
      expect(human_attributes(Page, :title, :permalink)).
        to eq [
          I18n.t('activerecord.attributes.page.title'),
          I18n.t('activerecord.attributes.page.permalink')
        ]
    end
  end
end
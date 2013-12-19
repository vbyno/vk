require 'acceptance_helper'

shared_examples 'pages are accessible' do |pages|
  pages.each do |page|
    it "#{page.url} is accessible" do
      expect(page.visit!).to be_loaded
    end
  end
end

describe 'homepage' do
  root_pages = Locale::ALL_LOCALES.map do |locale_sym|
    locale = Locale.new(locale_sym)
    BasicPage.new(locale.root_page_path,
                  main_content: I18n.t('apartments.index.headline', locale: locale))
  end

  after :all do
    Locale.change_to_default!
  end

  context 'witout apartments:' do
    before :all do
      Apartment.destroy_all
    end

    it_behaves_like 'pages are accessible', root_pages
  end

  context 'with apartment but without translations:' do
    before :all do
      Apartment.destroy_all
      create :apartment
    end

    it_behaves_like 'pages are accessible', root_pages
  end

  context 'with apartment and translations:' do
    before :all do
      Apartment.destroy_all
      create :apartment, :with_translations
    end

    it_behaves_like 'pages are accessible', root_pages
  end
end
require 'acceptance_helper'

describe 'homepage' do
  specify 'page is accessible' do
    Apartment.destroy_all

    Locale.all.each do |locale|
      main_page = create(:main_page, permalink: locale.to_s, locale: locale.to_s)
      page = BasicPage.new(locale.root_page_path, main_content: main_page.content)
      expect(page.visit!).to be_loaded

      create :apartment, :active_with_main_photo
      expect(page.visit!).to be_loaded

      create :apartment, :active_with_main_photo, :with_translations
      expect(page.visit!).to be_loaded
    end

    Locale.change_to_default!
  end
end

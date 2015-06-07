require 'acceptance_helper'

describe 'Apartment LP' do

  let(:apartment) { create :apartment,
                           :active_with_main_photo,
                           :with_translations }

  after :all do
    Locale.change_to_default!
  end

  it 'shows apartment for default locale' do
    apartment_page = BasicPage.new("/apartments/#{apartment.permalink}",
                                   main_content: apartment.title)
    expect(apartment_page.visit!).to be_loaded
  end

  Locale::SECONDARY.map do |locale|
    it "shows apartment in #{locale.upcase} translation" do
      title = apartment.translations.find_by!(locale: locale).title
      locale_apartment_page =
        BasicPage.new("/#{locale}/apartments/#{apartment.permalink}",
                      main_content: title)
      locale_apartment_page.visit!

      expect(locale_apartment_page).to be_loaded
    end
  end
end

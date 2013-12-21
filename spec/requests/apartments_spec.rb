require 'acceptance_helper'

describe 'Apartment LP' do

  let(:apartment) { create :apartment, :with_translations }

  after :all do
    Locale.change_to_default!
  end

  it 'shows apartment for default locale' do
    apartment_page = BasicPage.new("/apartments/#{apartment.id}",
                                   main_content: apartment.title)
    expect(apartment_page.visit!).to be_loaded
  end

  ApartmentTranslation::LOCALES.map do |locale|
    it "shows apartment in #{locale.upcase} translation" do
      locale_apartment_page = BasicPage.new("/#{locale}/apartments/#{apartment.id}",
                                            main_content: apartment.translated_title(locale))
      expect(locale_apartment_page.visit!).to be_loaded
    end
  end
end
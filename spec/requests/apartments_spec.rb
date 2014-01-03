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

  context 'reservation' do
    before do
      I18n.locale = :ru
      # TODO fix it in another way. Why application controller does not change it?
    end

    it 'is can be created', js: true do
      apartment_page = Apartment::ShowPage.new(apartment_path(apartment)).visit!
      apartment_page.reservation_form.fill_with(
        I18n.t('formtastic.labels.reservation.customer_name') => 'Name Ru',
        I18n.t('formtastic.labels.reservation.customer_email') => 'Email Ru',
        I18n.t('formtastic.labels.reservation.check_in') => '11/12/2012',
        I18n.t('formtastic.labels.reservation.check_out') => '12/12/2012'
      ).submit_button.click!
      wait_for_ajax
      expect(page).to have_content 'Ваш email имеет неверное значение'

      apartment_page.reservation_form.fill_with(
        I18n.t('formtastic.labels.reservation.customer_email') => 'email@ru.comx'
      ).submit_button.click!
      wait_for_ajax
      expect(page).to have_content I18n.t('reservations.create.thank_you')
    end
  end
end

def wait_for_ajax
  counter = 0
  while page.execute_script('return $.active').to_i > 0
    counter += 1
    sleep(0.1)
    raise 'AJAX request took longer than 5 seconds.' if counter >= 50
  end
end

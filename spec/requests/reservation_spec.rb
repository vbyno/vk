require 'acceptance_helper'

describe 'reservation' do
  let(:apartment) { create :apartment,
                           :active_with_main_photo,
                           :with_translations }
  delegate :permalink, to: :apartment

  before do
    Locale.change_to_default!
  end

  it 'can be created', js: true do
    apartment_page = Apartment::ShowPage.new(apartment_path(permalink)).visit!
    apartment_page.reservation_form.fill_with(
      I18n.t('formtastic.labels.reservation.customer_name') => 'Name Ru',
      I18n.t('formtastic.labels.reservation.customer_email') => 'Email Ru',
      I18n.t('formtastic.labels.reservation.customer_phone') => '380673030330',
      I18n.t('formtastic.labels.reservation.check_in') => '11/12/2012',
      I18n.t('formtastic.labels.reservation.check_out') => '12/12/2012'
    ).submit_button.click!

    apartment_page.wait_for_ajax

    expect(page).to have_content 'Ваш email имеет неверное значение'

    apartment_page.reservation_form.fill_with(
      I18n.t('formtastic.labels.reservation.customer_email') => 'email@ru.comx'
    ).submit_button.click!

    apartment_page.wait_for_ajax

    expect(page).to have_content I18n.t('reservations.create.thank_you')
  end
end

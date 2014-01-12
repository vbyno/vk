require 'acceptance_helper'

describe 'reservation' do
  let(:apartment) { create :apartment, :with_translations }

  it 'can be created', js: true do
    apartment_page = Apartment::ShowPage.new(apartment_path(apartment)).visit!
    apartment_page.reservation_form.fill_with(
      I18n.t('formtastic.labels.reservation.customer_name') => 'Name Ru',
      I18n.t('formtastic.labels.reservation.customer_email') => 'Email Ru',
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

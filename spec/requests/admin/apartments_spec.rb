require 'acceptance_helper'

describe 'admin/apartments' do
  let!(:default_apartment) { create :apartment }

  let(:index_page) { Admin::ApartmentsIndexPage.new }
  let(:new_page) { Admin::ApartmentsNewPage.new }

  let(:new_apartment_params) { { 'Заголовок' => 'Apartment 1 Title',
                                 'Цена' => '300.55',
                                 'Описание' => 'Apartment Description' } }
  let(:update_apartment_params) { { 'Заголовок' => 'Apartment 2 Title' } }

  before do
    login_as create(:admin_user), scope: :admin_user
    Locale.change_to_default!
  end

  it 'CRUD apartment', js: true do
    index_page.visit!
    expect(index_page).to be_loaded
    expect(index_page).to have_apartments(default_apartment)

    index_page.new_button.click!
    expect(new_page).to be_loaded

    new_page.form.fill_with(new_apartment_params).submit_button.click!

    apartment = Apartment.last
    show_page = Admin::ApartmentsShowPage.new(apartment)

    expect(show_page).to be_loaded
    expect(show_page).to have_apartment(apartment)
    expect(apartment).not_to eq default_apartment

    show_page.edit_button.click!

    edit_page = Admin::ApartmentsEditPage.new(apartment)
    expect(edit_page).to be_loaded

    edit_page.form.fill_with(update_apartment_params).submit_button.click!
    expect(show_page).to be_not_loaded
    expect(Admin::ApartmentsShowPage.new(apartment.reload)).to be_loaded
  end
end

require 'acceptance_helper'

describe 'admin/apartments' do
  let!(:apartment) { create :apartment }
  let(:apartment_attributes_hash) {
    { attributes: [:title, :description, :price, :short_description] }
  }

  let(:new_apartment_params) { { 'Заголовок' => 'Apartment 1 Title',
                                 'Цена' => '300.55',
                                 'Описание' => 'Apartment Description',
                                 'Short description' => 'Apartment Short Description' } }
  let(:update_apartment_params) { { 'Заголовок' => 'Apartment 2 Title' } }

  before do
    login_as create(:admin), scope: :admin
    Locale.change_to_default!
  end

  xit 'CRUD apartment', js: true do
    index_page = Admin::IndexPage.new(Apartment)
    expect(index_page.visit!).to have_instances(apartment, apartment_attributes_hash)
    index_page.new_button.click!

    new_page = Admin::NewPage.new(Apartment,
                                  tiny_mce_textareas: 'Описание')
    expect(new_page).to be_loaded
    new_page.form.fill_with(new_apartment_params).submit_button.click!

    new_apartment = Apartment.last
    show_page = Admin::ShowPage.new(new_apartment)
    expect(show_page).to be_loaded
    expect(show_page).to have_instance(new_apartment, apartment_attributes_hash)
    show_page.edit_button.click!

    edit_page = Admin::EditPage.new(new_apartment)
    expect(edit_page).to be_loaded

    edit_page.form.fill_with(update_apartment_params).submit_button.click!
    expect(show_page).to be_not_loaded
    expect(Admin::ShowPage.new(new_apartment.reload)).to be_loaded

    expect(index_page.visit!).to have_instances(apartment,
                                                new_apartment,
                                                apartment_attributes_hash)
  end
end

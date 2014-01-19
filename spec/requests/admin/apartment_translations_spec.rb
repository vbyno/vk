require 'acceptance_helper'

describe 'admin/apartments' do
  let!(:translation) { create :apartment_translation }
  let(:translation_attributes_hash) {
    { attributes: [:title, :description, :short_description, :locale] }
  }
  let(:new_translation_params) { { 'Apartment' => translation.apartment.title,
                                   'Locale' => 'ua',
                                   'Title' => 'Unique Translation Title',
                                   'Description' => 'Unique Translation Description',
                                   'Short description' => 'Short Description' } }
  let(:update_translation_params) { { 'Title' => 'Unique Translation New Title' } }

  before do
    login_as create(:admin), scope: :admin
    Locale.change_to_default!
  end

  it 'CRUD apartment translation', js: true do
    index_page = Admin::IndexPage.new(ApartmentTranslation)
    expect(index_page.visit!).to have_instances(translation, translation_attributes_hash)
    index_page.new_button.click!

    new_page = Admin::NewPage.new(ApartmentTranslation,
                                  selects: ['Apartment', 'Locale'],
                                  tiny_mce_textareas: 'Description')
    expect(new_page).to be_loaded
    new_page.form.fill_with(new_translation_params).submit_button.click!

    new_translation = ApartmentTranslation.last
    show_page = Admin::ShowPage.new(new_translation)
    expect(show_page).to be_loaded
    expect(show_page).to have_instance(new_translation, translation_attributes_hash)
    # TODO - to have link to apartment!
    show_page.edit_button.click!

    edit_page = Admin::EditPage.new(new_translation)
    # expect(Admin::EditPage.new(translation)).to be_not_loaded
    # TODO - This fails, but should pass. Think about unique main content
    expect(edit_page).to be_loaded

    edit_page.form.fill_with(update_translation_params).submit_button.click!
    expect(show_page).to be_not_loaded
    expect(Admin::ShowPage.new(new_translation.reload)).to be_loaded

    expect(index_page.visit!).to have_instances(translation,
                                                new_translation,
                                                translation_attributes_hash)
  end
end

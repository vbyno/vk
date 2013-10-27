require 'acceptance_helper'

describe 'admin/apartments' do
  it 'creates new apartment' do
    login_as create :admin_user
    visit new_admin_user_session_path

    click_on 'Apartments'
    click_on 'New Apartment'
    fill_in 'Title', with: 'Best Apartment'
    fill_in 'Price', with: 'Best Price'
    fill_in 'Description', with: 'Some Description'
    click_on 'Create Apartment'

    expect(page).to have_content 'Apartment was successfully created.'
  end
end
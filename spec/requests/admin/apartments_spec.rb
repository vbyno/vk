require 'acceptance_helper'

describe 'admin/apartments' do
  let(:apartments_page) { Admin::ApartmentsPage.new }
  let(:apartment) { { 'Заголовок' => 'Best Apartment',
                      'Цена' => '200',
                      'Описание' => 'Some Description' } }

  before do
    login_as create(:admin_user), scope: :admin_user
  end

  it 'is able to create new apartment' do
    expect(apartments_page
           .visit!
           .create_new_apartment!(apartment)
          ).to be_successful
  end
end
require 'acceptance_helper'

describe 'admin/login' do
  let(:admin_login_page) { Admin::LoginPage.new }
  let(:admin) { create :admin }

  # TODO investigate why this does not working
  xit 'allows admin to log in' do
    Locale.change_to_default!
    admin_login_page.visit!.log_in(admin)
    expect(admin_login_page).to be_loaded
  end
end

require 'acceptance_helper'

describe 'admin/login' do
  let(:admin_login_page) { Admin::LoginPage.new }
  let(:admin) { create :admin_user }

  it 'allows admin to log in' do
    admin_login_page.visit!.log_in(admin)
    expect(admin_login_page).to be_loaded
  end
end
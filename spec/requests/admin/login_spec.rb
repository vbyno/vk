
require 'acceptance_helper'

describe 'admin/login' do
  it 'allows admin to log in' do
    admin = create :admin_user
    visit new_admin_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Пароль', with: admin.password
    click_on 'Войти'

    expect(page).to have_content 'Панель управления'
  end
end
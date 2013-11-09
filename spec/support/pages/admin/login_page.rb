require 'support/pages/base_page.rb'

class Admin::LoginPage < BasePage
  def initialize
    super(new_admin_user_session_path)
  end

  def log_in(admin)
    fill_in 'Email', with: admin.email
    fill_in 'Пароль', with: admin.password
    click_on 'Войти'
    self
  end

  def loaded?
    content = 'Панель управления'
    return true if has_content? content
    raise "Expected Admin::LoginPage to have content '#{content}'"\
          " but it was not found"
  end
end

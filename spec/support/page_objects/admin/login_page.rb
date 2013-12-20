class Admin::LoginPage < BasicPage
  def initialize
    super(new_admin_user_session_path, main_content: 'Панель управления')
  end

  def log_in(admin)
    form.fill_with('Email' => admin.email, 'Пароль' => admin.password).submit_button.click!
    self
  end

  def form
    BasicForm.new(submit: 'Войти')
  end
end

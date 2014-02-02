class Admin::LoginPage < BasicPage
  def initialize
    main_content = Apartment.model_name.human(:count => Float::INFINITY)
    super(new_admin_session_path, main_content: main_content)
  end

  def log_in(admin)
    email = Admin.human_attribute_name :email
    password = Admin.human_attribute_name :password
    form.fill_with(email => admin.email, password => admin.password).
         submit_button.click!
    self
  end

  def form
    BasicForm.new(submit: 'Войти')
  end
end

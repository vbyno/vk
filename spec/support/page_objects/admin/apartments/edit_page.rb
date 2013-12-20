class Admin::ApartmentsEditPage < BasicPage
  def initialize(apartment)
    @url = edit_admin_apartment_path(apartment)
    @main_content = 'Изменить Apartment'
  end

  def form
    BasicForm.new(tiny_mce_textareas: 'Описание',
                  submit: I18n.t('admin.apartments.submit'))
  end
end
class Admin::ApartmentsNewPage < BasicPage
  def initialize
    @url = new_admin_apartment_path
    @main_content = 'Создать Apartment'
  end

  def form
    BasicForm.new(tiny_mce_textareas: 'Описание',
                  submit: I18n.t('admin.apartments.submit'))
  end
end
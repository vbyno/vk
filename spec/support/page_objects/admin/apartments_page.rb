class Admin::ApartmentsPage < BasicPage
  def initialize
    super(admin_apartments_path)
  end

  def create_new_apartment!(apartment_params)
    click_on 'Создать Apartment'
    form.fill_in_with(apartment_params).submit!
    self
  end

  def form
    BasicForm.new(tiny_mce_textareas: 'Описание',
                  submit: I18n.t('admin.apartments.submit'))
  end

  def successful?
    content = 'Apartment подробнее'
    return true if has_content? content
    raise "Expected Admin::ApartmentsPage to have content '#{content}'"\
          " but it was not found"
  end
end

class Admin::ApartmentsPage < BasePage
  CONTENT = {
    new: 'Создать Apartment',
    create: I18n.t('admin.apartments.submit'),
    successfully_created: 'Apartment was successfully created.'
  }
  TINY_MCE_LABEL = 'Описание'

  def initialize
    super(admin_apartments_path)
  end

  def create_new_apartment!(apartment_params)
    click_on CONTENT[:new]
    fill_in_form(apartment_params)
    click_on CONTENT[:create]
    self
  end

  def fill_in_form(apartment_params)
    apartment_params.each do |label, value|
      if label == TINY_MCE_LABEL
        fill_in_tinymce label, with: value
      else
        fill_in label, with: value
      end
    end
  end

  def successful?
    content = CONTENT[:successfully_created]
    return true if has_content? content
    raise "Expected Admin::ApartmentsPage to have content '#{content}'"\
          " but it was not found"
  end
end

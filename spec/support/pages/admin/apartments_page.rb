require 'support/pages/base_page.rb'

class Admin::ApartmentsPage < BasePage
  def initialize
    super(admin_apartments_path)
  end

  def create_new_apartment!(apartment_params)
    click_on 'Создать Apartment'
    fill_in_form(apartment_params)
    click_on 'Сохранить Apartment'
    self
  end

  def fill_in_form(apartment_params)
    apartment_params.each do |label, value|
      fill_in label, with: value
    end
  end

  def successful?
    content = 'Apartment was successfully created.'
    return true if has_content? content
    raise "Expected Admin::ApartmentsPage to have content '#{content}'"\
          " but it was not found"
  end
end

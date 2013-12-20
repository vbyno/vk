class Admin::ApartmentsShowPage < BasicPage
  VISIBLE_ATTRIBUTES = [:title, :description, :price]

  def initialize(apartment)
    @url = admin_apartment_path(apartment)
    @main_content = apartment.title
  end

  def edit_button
    BasicButton.new(value: 'Изменить Apartment')
  end

  def has_apartment?(apartment)
    VISIBLE_ATTRIBUTES.each do |attr|
      content = apartment.public_send(attr)
      unless has_content? content
        raise "Expected #{self.class} to have content '#{content}'"\
              " but it was not found"
      end
    end
  end
end
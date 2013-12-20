class Admin::ApartmentsIndexPage < BasicPage
  VISIBLE_ATTRIBUTES = [:title, :description, :price]

  def initialize
    @url = admin_apartments_path
    @main_content = 'Apartments'
  end

  def new_button
    BasicButton.new(value: 'Создать Apartment')
  end

  def has_apartments?(*apartments)
    apartments.each do |apartment|
      VISIBLE_ATTRIBUTES.each do |attr|
        content = apartment.public_send(attr)
        unless has_content? content
          raise "Expected #{self.class} to have content '#{content}'"\
                " but it was not found"
        end
      end
    end
  end
end
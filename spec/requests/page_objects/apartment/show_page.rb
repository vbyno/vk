class Apartment::ShowPage < BasicPage
  def reservation_form
    BasicForm.new(submit: 'Забронировать!')
  end
end

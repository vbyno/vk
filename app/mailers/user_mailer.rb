class UserMailer < ActionMailer::Base
  default from: "vk.lviv.ua@gmail.com"

  def reservation_created(reservation_id)
    @reservation = Reservation.find(reservation_id)

    mail(to: @reservation.customer_mail, subject: 'Reservation Left')
  end
end

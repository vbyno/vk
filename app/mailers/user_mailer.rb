class UserMailer < BaseMailer
  def reservation_created(reservation_id)
    @reservation = Reservation.find(reservation_id)

    mail(to: @reservation.customer_email, subject: 'Reservation Left')
  end
end

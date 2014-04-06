class AdminMailer < BaseMailer
  default to: Figaro.env.admin_email

  def yesterdays_reservations(time)
    @reservations = Reservation.yesterdays(time)

    mail(subject: "Yesterday's reservations")
  end
end

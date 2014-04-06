class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      Resque.enqueue(MailerWorker, 'UserMailer',
                     :reservation_created, @reservation.id)
    end
  end

private
  def reservation_params
    params.require(:reservation).permit(
      :apartment_id, :check_in, :check_out, :body,
      :customer_name, :customer_email, :customer_phone
    )
  end
end

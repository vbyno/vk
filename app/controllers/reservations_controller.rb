class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
  end

private
  def reservation_params
    params.require(:reservation).permit(
      :apartment_id,
      :customer_name,
      :customer_email,
      :check_in,
      :check_out,
      :body
    )
  end
end

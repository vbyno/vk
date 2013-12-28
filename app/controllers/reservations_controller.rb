class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to root_path, notice: 'Reservation was successfully created.'
    else
      raise Exception.new
    end
  end

private
  def reservation_params
    params.require(:reservation).permit(
      :apartment_id,
      :customer_name,
      :customer_email,
      :check_in,
      :check_out
    )
  end
end
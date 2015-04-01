class ApartmentsController < ApplicationController
  before_action :find_apartment

  def show
    @apartment = ApartmentPresenter.create_by_locale(@apartment, @locale)
    @reservation = @apartment.reservations.build
  end

private
  def find_apartment
    @apartment = Apartment.available!(params[:permalink])
  end
end

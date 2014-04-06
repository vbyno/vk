class ApartmentsController < ApplicationController
  load_resource

  def show
    @apartment = ApartmentPresenter.create_by_locale(@apartment, @locale)
    @reservation = @apartment.reservations.build
  end
end

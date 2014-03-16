class ApartmentsController < ApplicationController
  load_resource only: :show

  def index
    @apartments = ApartmentPresenter.all(@locale)
  end

  def show
    @apartment = ApartmentPresenter.create_by_locale(@apartment, @locale)
    @reservation = @apartment.reservations.build
  end
end

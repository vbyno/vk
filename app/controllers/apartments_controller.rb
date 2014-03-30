class ApartmentsController < ApplicationController
  load_resource only: :show

  def index
    @apartments = ApartmentPresenter.all(@locale)
    @main_page = MainPage.available(@locale)
  end

  def show
    @apartment = ApartmentPresenter.create_by_locale(@apartment, @locale)
    @reservation = @apartment.reservations.build
  end
end

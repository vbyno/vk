class ApartmentsController < ApplicationController
  load_resource only: :show

  def index
    @apartments = ApartmentPresenter.all(@locale)
  end

  def show
    @apartment = ApartmentPresenter.new(@apartment, locale: @locale)
  end
end

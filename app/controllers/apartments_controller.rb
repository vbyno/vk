class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.available!(params[:permalink])
  end
end

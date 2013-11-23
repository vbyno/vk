class ApartmentsController < ApplicationController
  load_and_authorize_resource only: :show

  def index;
    @apartments = ApartmentHandler.all(@locale)
  end

  def show; end
end

class ApartmentsController < ApplicationController
  before_action :authenticate_admin_user!, except: [:index, :show]
  load_and_authorize_resource except: [:create]

  def index;
    @apartments = ApartmentHandler.all(@locale)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.save
      redirect_to @apartment, notice: 'Apartment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to @apartment, notice: 'Apartment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @apartment.destroy
    redirect_to apartments_path
  end

private
  def apartment_params
    params.require(:apartment).permit(:title, :price, :description)
  end
end

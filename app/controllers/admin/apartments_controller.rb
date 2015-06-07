class Admin::ApartmentsController < Admin::BaseController
  def index; end
  def new; end

  def create
    @apartment = Apartment.create(apartment_params)
    render 'create_update'
  end

  def edit; end

  def update
    @apartment.update(apartment_params)
    render 'create_update'
  end

  private

  def apartment_params
    params.require(:apartment).permit(
      :title, :active, :price, :short_description, :description,
      :main_photo_id, :permalink,
      photos_attributes: [:id, :alt, :title, :image, :apartment_id, :_destroy]
    )
  end
end

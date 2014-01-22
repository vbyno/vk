class Admin::ApartmentsController < Admin::BaseController
  load_and_authorize_resource except: :create
  authorize_resource only: :create

  def index; end
  def new; end
  def edit; end

  def create
    @apartment = Apartment.create(apartment_params)
    render 'create_update'
  end

  def update
    @apartment.update(apartment_params)
    render 'create_update'
  end

private
  def apartment_params
    params.require(:apartment).permit(
      :title,
      :active,
      :price,
      :short_description,
      :description,
      :main_image_id,
      photos_attributes: [:id,
                          :alt,
                          :title,
                          :image,
                          :apartment_id,
                          :_destroy]
    )
  end
end
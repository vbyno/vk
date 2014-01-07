class Admin::ApartmentsController < Admin::BaseController
  load_and_authorize_resource

  def index; end

  def edit; end

  def update
    if @apartment.update(apartment_params)
      redirect_to admin_apartments_path,
                  notice: 'Apartment was successfully updated!'
      return
    else
      render :edit
    end
  end

private
  def apartment_params
    params.require(:apartment).permit(
      :title,
      :active,
      :price,
      :short_description,
      :description,
      :main_image_id
    )
  end
end
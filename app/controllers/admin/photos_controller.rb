class Admin::PhotosController < Admin::BaseController
  authorize_resource only: :create

  def create
    @photo = Photo.create(photo_params)
  end

private
  def photo_params
    params[:photo].merge!({ apartment_id: params[:apartment_id] })
    params.require(:photo).permit(
      :apartment_id,
      :alt,
      :title,
      :image
    )
  end
end

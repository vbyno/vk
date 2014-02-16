class Admin::PicturesController < Admin::BaseController
  respond_to :json

  def create
    @picture = Picture.create(picture_params)
  end

private
  def picture_params
    params.require(:picture).permit(:picture_id, :imageable_id, :imageable_type,
                                    :image, :alt, :title)
  end
end

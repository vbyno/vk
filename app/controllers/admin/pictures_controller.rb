class Admin::PicturesController < Admin::BaseController
  respond_to :js

  def new
    @picture = Picture.new(new_picture_params)
  end

  def create
    @picture = Picture.create(picture_params)
  end

private
  def new_picture_params
    params.permit(:imageable_id, :imageable_type)
  end

  def picture_params
    params.require(:picture).permit(:picture_id, :imageable_id, :imageable_type,
                                    :image, :alt, :title)
  end
end

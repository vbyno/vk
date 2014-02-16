class Admin::ApartmentTranslationsController < Admin::BaseController
  def new; end

  def create
    @apartment_translation = ApartmentTranslation.new(create_params)
    if @apartment_translation.save
      redirect_to admin_apartments_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    @apartment_translation.update(update_params)
    render :edit
  end

private
  def create_params
    params[:apartment_translation][:apartment_id] ||= params[:apartment_id]
    params.require(:apartment_translation).permit(
      :title, :short_description, :description, :locale, :apartment_id
    )
  end

  def update_params
    params.require(:apartment_translation).permit(
      :title, :short_description, :description,
      photo_translations_attributes: [:id, :photo_id, :alt, :title, :_destroy]
    )
  end
end

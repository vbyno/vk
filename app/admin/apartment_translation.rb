ActiveAdmin.register ApartmentTranslation do
  controller do
    def permitted_params
      params.permit apartment_translation: [:apartment_id, :title, :description, :locale]
    end
  end

  index do
    column :apartment
    column :locale
    column :title
    column :description
    default_actions
  end
end

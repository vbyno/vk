ActiveAdmin.register GalleryImage do
  controller do
    def permitted_params
      params.permit gallery_image: [:apartment_id, :image, :title, :alt]
    end
  end

  menu label: I18n.t('admin.menu_labels.gallery_images', locale: Locale::DEFAULT)

  index do
    column :apartment
    column :image
    column :title
    column :alt
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'GalleryImage' do
      f.input :apartment, as: :select, collection: Apartment.all
      f.input :image
      f.input :title
      f.input :alt
    end
    f.actions
  end
end
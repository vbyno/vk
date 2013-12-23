ActiveAdmin.register Apartment do
  controller do
    def permitted_params
      params.permit apartment: [:title,
                                :active,
                                :price,
                                :short_description,
                                :description,
                                :main_image_id]
    end
  end

  menu label: I18n.t('admin.menu_labels.apartments', locale: Locale::DEFAULT)

  index do
    column :title
    column :price
    column :short_description
    column :description
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Apartment' do
      f.input :active
      f.input :main_image, as: :select, collection: f.object.gallery_images
      f.input :title
      f.input :price
      f.input :short_description
      f.input :description, input_html: { class: 'tinymce' }
    end
    f.actions
  end
end

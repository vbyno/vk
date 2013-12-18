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

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'ApartmentTranslation' do
      f.input :locale
      f.input :title
      f.input :description, input_html: { class: 'tinymce' }
    end
    f.actions
  end
end

ActiveAdmin.register ApartmentTranslation do
  controller do
    def permitted_params
      params.permit apartment_translation: [:title,
                                            :description,
                                            :locale,
                                            :short_description,
                                            :apartment_id]
    end
  end

  menu label: I18n.t('admin.menu_labels.apartment_translations', locale: Locale::DEFAULT)

  index do
    column :apartment
    column :locale
    column :title
    column :short_description
    column :description # TODO dotdotdot or truncate
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'ApartmentTranslation' do
      f.input :apartment
      f.input :locale, as: :select, collection: ApartmentTranslation::LOCALES
      f.input :title
      f.input :short_description
      f.input :description, input_html: { class: 'tinymce' }
    end
    f.actions
  end
end

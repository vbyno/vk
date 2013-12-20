ActiveAdmin.register Apartment do
  controller do
    def permitted_params
      params.permit apartment: [:title, :price, :description]
    end
  end

  menu label: I18n.t('admin.apartments.menu_label', locale: Locale::DEFAULT)

  index do
    column :title
    column :description
    column :price
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Apartment' do
      f.input :title
      f.input :price
      f.input :description, input_html: { class: 'tinymce' }
    end
    f.actions do
      f.action :submit, label: I18n.t('admin.apartments.submit')
      f.action :cancel, label: I18n.t('admin.apartments.cancel')
    end
  end
end

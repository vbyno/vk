ActiveAdmin.register Apartment do
  controller do
    def permitted_params
      params.permit apartment: [:title, :price, :description]
    end
  end

  index do
    column :title
    column :description
    column :price
    default_actions
  end
end

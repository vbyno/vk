ActiveAdmin.register Apartment do
  controller do
    def permitted_params
      params.permit apartment: [:title, :price, :description]
    end
  end
end

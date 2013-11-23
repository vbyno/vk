class ApartmentTranslationsController < InheritedResources::Base
  before_action :authenticate_admin_user!, except: [:index, :show]
end
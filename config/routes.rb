Vk::Application.routes.draw do
  concern :apartment_presenter do
    root 'main_pages#show'
    resources :apartments, only: :show
  end

  concern :seo_hierarchical do
    get '/:parent_permalink' => 'parent_pages#show', as: :parent_page
    get '/:parent_permalink/:child_permalink' => 'child_pages#show',
                                                 as: :child_page
  end

  concerns :apartment_presenter
  resources :reservations, only: :create

  devise_for :admins

  namespace :admin do
    resources :apartments, except: :show do
      resources :photos, only: :create
      resources :apartment_translations, only: [:new, :create],
                as: :translations, path: :translations
    end
    resources :apartment_translations, :reservations, only: [:edit, :update]
    resources :pages, only: [:index, :new, :create, :edit, :update]
    resources :pictures, only: [:new, :create]
  end

  scope ':locale', locale: /ua|en|pl/, as: :locale do
    concerns :apartment_presenter, :seo_hierarchical
  end
  concerns :seo_hierarchical
end

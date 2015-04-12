Vk::Application.routes.draw do
  concern :apartments_concern do
    root 'main_pages#show'
    get 'apartments/:permalink' => 'apartments#show', as: :apartment
  end

  concern :pages_concern do
    get '/:parent_permalink' => 'parent_pages#show', as: :parent_page
    get '/:parent_permalink/:child_permalink' => 'child_pages#show',
                                                 as: :child_page
  end

  concerns :apartments_concern
  resources :reservations, only: :create

  namespace :admin do
    resources :apartments, except: :show do
      resources :photos, only: :create
      resources :apartment_translations, only: [:new, :create],
                as: :translations, path: :translations
    end
    resources :apartment_translations, :reservations, only: [:edit, :update]
    resources :pages, except: :show
    resources :pictures, only: [:new, :create]
  end

  get '/sitemap', to: 'static_pages#sitemap', as: :sitemap

  Redirect.each do |old_path, new_path|
    get "#{old_path}.html", to: redirect(new_path)
  end

  scope ':locale', locale: /ua|en|pl/, as: :locale do
    concerns :apartments_concern, :pages_concern
  end

  devise_for :admin

  concerns :pages_concern
end

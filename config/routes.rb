Vk::Application.routes.draw do
  root 'apartments#index'

  resources :apartments, only: :show
  resources :reservations, only: :create

  devise_for :users
  devise_for :admins

  namespace :admin do
    resources :apartments, except: :show do
      resources :photos, only: :create
      resources :apartment_translations, only: [:new, :create],
                as: :translations, path: :translations
    end
    resources :apartment_translations, :reservations, only: [:edit, :update]
  end

  scope ':locale', locale: /ua|en|pl/ do
    resources :apartments, as: :locale_apartments, only: :show
    root 'apartments#index', as: :locale_root
  end

  get '/:parent_permalink' => 'parent_pages#show', as: :parent_page
  get '/:parent_permalink/:child_permalink' => 'child_pages#show',
                                               as: :child_page
end

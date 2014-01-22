Vk::Application.routes.draw do
  root 'apartments#index'

  resources :apartments, only: :show
  resources :reservations, only: :create

  devise_for :users
  devise_for :admins

  namespace :admin do
    resources :apartments, except: :show do
      resources :photos, only: :create
    end
    resources :reservations, only: [:edit, :update]
  end

  scope ':locale', locale: /ua|en|pl/ do
    resources :apartments, as: :locale_apartments, only: :show
    root 'apartments#index', as: :locale_root
  end
end

Vk::Application.routes.draw do
  root 'apartments#index'

  resources :apartments, only: [:index, :show]

  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope ':locale', locale: /ua|en|pl/ do
    resources :apartments, as: :locale_apartments
    root 'apartments#index', as: :locale_root
  end
end

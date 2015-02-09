module Redirect
  extend self
  delegate :each, to: :redirects

  def node
    @file ||=
      YAML.load_file(Rails.root.join('config', 'redirects.yml')).with_indifferent_access
  end

  def redirects
    (node[:children]).inject({}) do |result, (parent_key, children)|
      result.merge(condition_hash(parent_key, children))
    end
    .merge(node[:parents])
  end

private
  def condition_hash(parent_key, children)
    prefix = "#{parent_key}/" if parent_key.in?(['ua', 'en'])
    Hash[children.map { |key, value| ["#{parent_key}/#{key}", "#{prefix}#{value}"] }]
  end
end

Vk::Application.routes.draw do
  concern :apartments_concern do
    root 'main_pages#show'
    resources :apartments, only: :show
  end

  concern :pages_concern do
    get '/:parent_permalink' => 'parent_pages#show', as: :parent_page
    get '/:parent_permalink/:child_permalink' => 'child_pages#show',
                                                 as: :child_page
  end

  concerns :apartments_concern
  resources :reservations, only: :create

  devise_for :admins
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
  concerns :pages_concern
end

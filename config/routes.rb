Rails.application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
    end
  end
end

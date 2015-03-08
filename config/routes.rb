Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end

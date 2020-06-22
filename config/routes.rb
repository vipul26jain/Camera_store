Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  get 'products/index'

  namespace :api, as: nil, defaults: { format: 'json' } do
    namespace :v1, as: nil do
      post 'registrations',  to: 'registrations#create', as: 'registrations'
      resources :products, :only => [:index]
      resources :users, :only => [:cart]
      get 'cart',  to: 'users#cart', as: 'cart'
      post 'login',  to: 'sessions#login', as: 'api_login'
      post 'add_product_to_cart',  to: 'products#add_product_to_cart', as: 'add_product_to_cart'
      delete 'logout',  to: 'sessions#logout', as: 'api_logout'
    end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

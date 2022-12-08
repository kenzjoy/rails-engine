Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all/', to: 'merchants_search#index'
      get '/merchants/find/', to: 'merchants_search#show'
      get 'items/find_all/', to: 'items_search#index'
      get 'items/find/', to: 'items_search#show'

      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', only: [:index]
      end
      resources :items do
        resources :merchant, controller: 'items_merchant', only: [:index]
      end
    end
  end
end

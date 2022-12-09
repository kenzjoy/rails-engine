Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all/', to: 'merchants_search#find_all'
      get '/merchants/find/', to: 'merchants_search#find'
      get 'items/find_all/', to: 'items_search#find_all'
      get 'items/find/', to: 'items_search#find'

      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', only: [:index]
      end
      resources :items do
        resources :merchant, controller: 'items_merchant', only: [:index]
      end
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find/', to: 'merchants_search#show'
      get 'items/find_all/', to: 'items_search#index'
      
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', only: [:index]
      end
      resources :items do
        resources :merchant, controller: 'items_merchant', only: [:index]
      end
    end
  end
end

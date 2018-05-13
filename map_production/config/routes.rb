Rails.application.routes.draw do
  resources :supply_chains
  resources :connections
  resources :suppliers
  resources :supply_maps
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

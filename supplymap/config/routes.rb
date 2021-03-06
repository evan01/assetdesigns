Rails.application.routes.draw do
  resources :product_types
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'

  # home path
  get 'home/' => 'home#index'

  # JSON Data request paths (see data_controller.rb for implementation)
  get 'all_products/' => 'data#all_products'
  get 'all_shops/' => 'data#all_shops'
  get 'all_suppliers/' => 'data#all_suppliers'
  get 'all_supplychains/' => 'data#all_supplychains'
  get 'all_connections/' => 'data#all_connections'
  get 'all_data/' => 'data#all_data'

  # Supply chains RESTful API (see supply_chains_controller.rb for controller and
  # views/supply_chains/ for html pages to show, modify and create new supply chains)
  get 'supply_chains/' => 'supply_chains#index'
  resources :supply_chains

  # Suppliers RESTful API (see suppliers_controller.rb for controller and
  # views/suppliers/ for html pages to show, modify and create new suppliers)
  get 'suppliers/' => 'suppliers#index'
  resources :suppliers do
    member do
      delete 'remove_image'
    end
  end

  get 'supplier_connections/' => 'supplier_connections#index'
  resources :supplier_connections


  get 'map' => 'map#supply_map'
end

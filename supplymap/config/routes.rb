Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  
  # home path
  get 'home/' => 'home#index'

  # JSON Data request paths (see data_controller.rb for implementation)
  get 'all_products/' => 'data#all_products'
  get 'all_shops/' => 'data#all_shops'
  get 'all_suppliers/' => 'data#all_suppliers'
  get 'all_supplychains/' => 'data#all_supplychains'

  # Supply chains RESTful API (see supply_chains_controller.rb for controller and 
  # views/supply_chains/ for html pages to show, modify and create new supply chains)
  get 'supply_chains/' => 'supply_chains#index'
  resources :supply_chains

  # Suppliers RESTful API (see suppliers_controller.rb for controller and 
  # views/suppliers/ for html pages to show, modify and create new suppliers)
  get 'suppliers/' => 'suppliers#index'
  resources :suppliers
end

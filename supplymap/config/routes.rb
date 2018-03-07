Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  
  #Example get route
  get 'supply_chain/' => 'supply_chain#test'
  get 'supply_chain/all_shops' => 'supply_chain#all_shops'

  get 'supply_chain/suppliers' => 'supply_chain#suppliers'
end
